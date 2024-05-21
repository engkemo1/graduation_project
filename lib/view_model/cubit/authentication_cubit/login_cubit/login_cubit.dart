
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';

import '../../../../models/login_model.dart';
import '../../../../view/screens/main_screen.dart';
import '../../../database/local.dart';
import '../../../database/network/dio_helper.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginMainState> {
  LoginCubit() : super(LoginMainInitialState());
  LoginData loginModel=LoginData() ;

  static LoginCubit get(context) => BlocProvider.of(context);
  login(
      BuildContext context,
      String email,
      String password,
      ) async {
    print(email);
    print(password);
    emit(LoginLoadingState());

    try {

      await DioHelper
          .postData(url: "$baseUrl$LOGIN",
        data:
        {
          "email": email,
          'password': password,
        }
        ,
      )
          .then((value) {
        print(value.data);

        loginModel=LoginData.fromJson(value.data['data']);
        CacheHelper.put(key: 'token', value: value.data["token"]);
        CacheHelper.put(key: 'name', value: loginModel.name);
        CacheHelper.put(key: 'email', value: loginModel.email);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MainScreen()));

        // showToast(message: value.data['message'], color: secondaryColor);
        print("sucessss");
        emit(LoginSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(LoginErrorState(e));
    }
  }

}

