import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/feature/notification/data/sqlite/CacheNotification.dart';
import 'package:e_commerce_basic_app/feature/notification/data/sqlite/NotificationTable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

final CacheNotification _cacheNotification = CacheNotification();

Future<void> notificationInitialization() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const iosInitializationSetting = DarwinInitializationSettings();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: iosInitializationSetting,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onSelectNotification,
    onDidReceiveBackgroundNotificationResponse: onSelectNotification,
  );
}

onSelectNotification(NotificationResponse notificationResponse) async {}


Future<void> scheduleNotification() async {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var androidDetails = const AndroidNotificationDetails(
    'channelId',
    'Channel Name',
    importance: Importance.high,
  );
  var platformChannelSpecifics =
  NotificationDetails(android: androidDetails);

  var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 120));
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Complete Your Purchase',
    'You have items in your cart. Complete your purchase!',
    scheduledTime,
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
}

Future<void> messageNotification(title, body) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          "message notification", "Messages Notifications",
          channelDescription: "show message to user",
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          autoCancel: false);

  NotificationDetails platformChannelSpecifics =
      const NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      Random().nextInt(1000000000), title, body, platformChannelSpecifics,
      payload: title);
}

Future<void> messageHandler(RemoteMessage message) async {
  debugPrint("notification from background :  ${message.notification}");
  messageNotification(message.notification!.title, message.notification!.body);

  _cacheNotification.insertNotification(NotificationTable.withOutId(
      title: message.notification!.title,
      subtitle: message.notification!.body,
      time : DateFormat('d,MMM,y hh:mm a').format(DateTime.parse(DateTime.now().toString()))
  ))
      .then((size) async {
    debugPrint("notification from background save to sqlite :  $size");
    final query = await FirebaseFirestore.instance
        .collection("notification")
        .get();
    for (var doc in query.docs) {
      query.docs[0].reference.update({'new_notification': true});
    }

  });
}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("notification from foreground :  ${message.notification}");
    messageNotification(
        message.notification!.title, message.notification!.body);
    _cacheNotification
        .insertNotification(NotificationTable.withOutId(
        title: message.notification!.title,
        subtitle: message.notification!.body,
        time : DateFormat('d,MMM,y hh:mm a').format(DateTime.parse(DateTime.now().toString()))
    ))
        .then((size) async {
      debugPrint("notification from foreground save to sqlite :  $size");
      final query = await FirebaseFirestore.instance
          .collection("notification")
          .get();
      for (var doc in query.docs) {
        query.docs[0].reference.update({'new_notification': true});
      }
    });
  });
}
