import 'package:bloc/bloc.dart';
import 'package:e_commerce_basic_app/core/failures.dart';
import 'package:e_commerce_basic_app/feature/notification/data/sqlite/CacheNotification.dart';
import 'package:e_commerce_basic_app/feature/notification/manager/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState.initial());

  final CacheNotification _cacheNotification = CacheNotification();


  void getNotifications() async {
    emit(state.copyWith(status: NotificationStatus.submitting));
    try{
      var result = await _cacheNotification.getNotifications();
      emit(state.copyWith(notifications: result, status: NotificationStatus.success));
    }catch(e){
      emit(state.copyWith(failure: ServerFailure(e.toString()), status: NotificationStatus.error));
    }


  }




}
