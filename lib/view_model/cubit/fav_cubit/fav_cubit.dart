
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/cart_model.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_state.dart';
import 'package:graduation_project/view_model/database/local.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';


class FavCubit extends Cubit<FavMainState> {
  FavCubit() : super(FavMainInitialState());

  static  FavCubit get(context) => BlocProvider.of(context);

  addFavourite(
String id
      ) async {
    try {

      await DioHelper
          .postData(url: "$baseUrl$favorite",data: {
        "eventId":id
      },token:CacheHelper.get(key: "token")

      )
          .then((value) {
        SmartDialog.showToast(value.data["message"]);

      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }
 deleteFavourite(
      String id
      ) async {
    try {

      await DioHelper
          .deleteData(url: "$baseUrl$favorite",data: {
        "eventId":id
      },token:CacheHelper.get(key: "token")

      )
          .then((value) {
        SmartDialog.showToast(value.data["message"]);

      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }


}}
