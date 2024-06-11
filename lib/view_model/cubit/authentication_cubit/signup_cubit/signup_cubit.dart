import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view/screens/admin/admin_home_screen.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/signup_cubit/signup_state.dart';
import 'package:graduation_project/view_model/database/network/dio_helper.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';

import '../../../../models/login_model.dart';
import '../../../../view/screens/main_screen.dart';
import '../../../database/local.dart';



class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(intiStateSignup());

  static SignupCubit GetInstence(context) => BlocProvider.of(context);

  // RegisterModel? Model;
  LoginData loginModel=LoginData() ;

  signUp(
      BuildContext context,
      String name,
      String email,
      String password,
    ) async {
    emit(SignupLoading());

    try {

      await DioHelper
          .postData(url: "$baseUrl$SIGNUP",
          data:
          {
            'name': name,
            "email": email,
            'password': password,
            "passwordConfirm":password,

          }
              ,
      )
          .then((value) {
            print(value.data);
          loginModel=LoginData.fromJson(value.data['data']["result"]);
          CacheHelper.put(key: 'token', value: value.data["token"]);
          CacheHelper.put(key: 'name', value: loginModel.name);
          CacheHelper.put(key: 'email', value: loginModel.email);
            CacheHelper.put(key: 'role', value: loginModel.role);
            CacheHelper.put(key: 'Booking', value: loginModel.booking);


            if(loginModel.role=="user"){
             Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                     builder: (_) => const MainScreen())  );
           }else{
             Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                     builder: (_) => const AdminHomeScreen())  );
           }
                // showToast(message: value.data['message'], color: secondaryColor);
        emit(SignupSuccess());
      });
    } on DioError catch (e) {
      SmartDialog.showToast(e.response?.data["errors"][0]["msg"]);
      print(e.response?.data["errors"][0]["msg"]);

      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(SignupError(e));
    }
  }

}