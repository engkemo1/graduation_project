
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/cubit/cart_cubit/cart_state.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_state.dart';
import 'package:graduation_project/view_model/database/local.dart';
import '../../../models/cart_model.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';


class CartCubit extends Cubit<CartMainState> {
  CartCubit() : super(CartMainInitialState());

  static  CartCubit get(context) => BlocProvider.of(context);
  List<CartItems> cartItems=[];

  getCartItems(

      ) async {
    emit(GetLoadingState());
    print("object");
    try {

      await DioHelper
          .getData(url: "$baseUrl$cart",

      )
          .then((value) {
        cartItems=
            (value.data["data"] as List).map((e) => CartItems.fromJson(e)).toList();
        print(cartItems);
        emit(GetSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(GetErrorState(e));
    }
  }

  updateCartItem(
      String id,
      String quantity
      ) async {
    try {

      await DioHelper
          .postData(url: "$baseUrl$cart/$id",data: {
        "quantity":id,
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


  addToCart(
      String id,
      String ticket
      ) async {
    emit(AddLoadingState());
    try {

      await DioHelper
          .postData(url: "$baseUrl$cart",data: {
        "eventId":id,
        "ticket":ticket
            },token:CacheHelper.get(key: "token")

      )
          .then((value) {
        SmartDialog.showToast(value.data["message"]);
        emit(AddSuccessState());

      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      emit(AddErrorState(e));

      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  deleteItem(
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
