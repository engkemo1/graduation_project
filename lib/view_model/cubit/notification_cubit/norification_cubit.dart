import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/fav_model.dart';
import 'package:graduation_project/models/notification_model.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_state.dart';
import 'package:graduation_project/view_model/database/local.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationMainState> {
  NotificationCubit() : super(NotificationMainInitialState());

  static NotificationCubit get(context) => BlocProvider.of(context);
  List<NotificationData> notificationModelList=[];

  Future getNotification() async {
    emit(NotificationLoadingState());
    try {
      await DioHelper.getData(
          url: "https://entertainia.onrender.com/api/v1/notice", token: CacheHelper.get(key: "token"))
          .then((value) {

        if (kDebugMode) {
          print(value);
        }
        if(value.data["results"]!=0){

          notificationModelList=(value.data["data"] as List).map((e)=>NotificationData.fromJson(e)).toList();

        }
        emit(NotificationLoadingState());


      });
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
      emit(NotificationErrorState(e));

    }
    return notificationModelList;
  }

  deleteNotification(String id,BuildContext context) async {

    try {
      await DioHelper.deleteData(
          url: "https://entertainia.onrender.com/api/v1/notice/$id",

          token: CacheHelper.get(key: "token"))
          .then((value) {
        NotificationCubit.get(context).getNotification();

        SmartDialog.showToast(value.data["message"]);
      });

    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
    }
  }
}
