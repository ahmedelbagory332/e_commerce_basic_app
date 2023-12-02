

import 'package:e_commerce_basic_app/feature/home/data/model/products_model.dart';
import 'package:e_commerce_basic_app/feature/notification/data/sqlite/NotificationTable.dart';
import 'package:equatable/equatable.dart';

import '../../../core/failures.dart';

enum NotificationStatus { initial, submitting, success, error }


class NotificationState extends Equatable {
  final NotificationStatus status;
  final List<NotificationTable> notifications;
  final Failure failure;
 


  const NotificationState({
    required this.status,
    required this.notifications,
    required this.failure,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      status: NotificationStatus.initial,
      notifications: [],
      failure: Failure("")

    );
  }

  @override
  List<Object> get props => [status,notifications,failure];

  NotificationState copyWith(
      {
        NotificationStatus? status,
        Failure? failure,
        List<NotificationTable>? notifications
      }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      failure: failure ?? this.failure,

    );
  }
}
