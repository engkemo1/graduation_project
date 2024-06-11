import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/fav_model.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_state.dart';
import 'package:graduation_project/view_model/database/local.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';

class FavCubit extends Cubit<FavMainState> {
  FavCubit() : super(FavMainInitialState());

  static FavCubit get(context) => BlocProvider.of(context);
List<FavData> favData=[];
  addFavourite(String id,BuildContext context) async {

    try {
      await DioHelper.postData(
              url: "$baseUrl$favorite",
              data: {"eventId": id},
              queryParameters: {"eventId": id},
              token: CacheHelper.get(key: "token"))
          .then((value) {
        FavCubit.get(context).favData.clear();

        FavCubit.get(context).getFavourite();

        SmartDialog.showToast(value.data["message"]);
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);

      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  Future getFavourite() async {
    favData=[];
    List id =[];
    emit(FavLoadingState());
    try {
      await DioHelper.getData(
              url: "$baseUrl$favorite", token: CacheHelper.get(key: "token"))
          .then((value) {

        if (kDebugMode) {
          print(value);
        }
        if(value.data["results"]!=0){

          favData=(value.data["data"] as List).map((e)=>FavData.fromJson(e)).toList();
          for (var e in favData) {
            id.add(e.sId);
          }
        }
        emit(FavLoadingState());

        return id;

      });
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.response);
      }
      emit(FavErrorState(e));

    }
    return id;
  }

  deleteFavourite(String id,BuildContext context) async {

    try {
      await DioHelper.deleteData(
              url: "$baseUrl$favorite?eventId=$id",

              token: CacheHelper.get(key: "token"))
          .then((value) {
        FavCubit.get(context).favData.clear();
        FavCubit.get(context).getFavourite();

        SmartDialog.showToast(value.data["message"]);
      });

    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
    }
  }
}
