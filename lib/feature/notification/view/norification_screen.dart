import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_basic_app/core/constants.dart';
import 'package:e_commerce_basic_app/core/error_widget.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_cubit.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    BlocProvider.of<NotificationCubit>(context).getNotifications();
     makeNotificationAsRead();
    super.initState();
  }

  Future<void> makeNotificationAsRead() async {
      final query = await FirebaseFirestore.instance
        .collection("notification")
        .get();
      query.docs[0].reference.update({'new_notification': false});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: kMainColor,
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.status) {
              case NotificationStatus.success:
                {
                  return Visibility(
                    visible: state.notifications.isNotEmpty,
                    replacement: Center(
                      child: Lottie.asset(
                        "assets/images/no_notification.json",
                        width: 300,
                        height: 100,
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        final notification = state.notifications[index];
                        return Card(
                          child: ListTile(
                            leading: SvgPicture.asset(
                              "assets/icons/notification.svg",
                              color: kMainColor,
                            ),
                            title: Text(notification.title ?? ""),
                            subtitle: Text(notification.subtitle ?? ""),
                            trailing: Text(notification.time ?? ""),
                          ),
                        );
                      },
                    ),
                  );
                }
                break;

              case NotificationStatus.error:
                {
                  return WidgetError(
                    refresh: () {
                      BlocProvider.of<NotificationCubit>(context)
                          .getNotifications();
                    },
                    subTitle: state.failure.errMessage,
                  );
                }
                break;

              case NotificationStatus.submitting:
                {
                  return const Center(child: CircularProgressIndicator());
                }
                break;

              case NotificationStatus.initial:
                {
                  return const SizedBox();
                }
                break;
            }
          }),
    );
  }
}
