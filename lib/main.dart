import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:timezone/data/latest.dart' as tz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/core/notifications.dart';
import 'package:e_commerce_basic_app/core/service_locator.dart';
import 'package:e_commerce_basic_app/feature/add_wallet/manager/add_wallet_cubit.dart';
import 'package:e_commerce_basic_app/feature/cart/manager/cart_cubit.dart';
import 'package:e_commerce_basic_app/feature/favorites/data/repo/favorites_repo_impl.dart';
import 'package:e_commerce_basic_app/feature/favorites/manager/favorites_cubit.dart';
import 'package:e_commerce_basic_app/feature/home/data/repo/home_repo_impl.dart';
import 'package:e_commerce_basic_app/feature/home/manager/home_cubit.dart';
import 'package:e_commerce_basic_app/feature/main_screen/main_screen.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_cubit.dart';
import 'package:e_commerce_basic_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
   tz.initializeTimeZones();
  await setupServiceLocator();
   await notificationInitialization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings =
  const Settings(persistenceEnabled: false);
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  firebaseMessagingListener();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint("fcm token :  $value");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            getIt.get<HomeRepoImpl>(),
          )..getCategories(),
        ),
        BlocProvider(
          create: (context) => NotificationCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritesCubit(getIt.get<FavoritesRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => AddNewWalletCubit(),
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter E-Commerce',
          home: MainScreen(),
        ),
      ),
    );
  }
}