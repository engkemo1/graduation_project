import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/signup_cubit/signup_state.dart';
import 'package:graduation_project/view_model/database/network/dio_helper.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';

import '../../../../models/login_model.dart';
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


      FormData formData = FormData.fromMap({
        'name': name,
        "email": email,
        'password': password,
        "passwordConfirm":"user123",

      });

      await DioHelper
          .postData(url: "https://entertainiaa.onrender.com/api/v1/auth/signup",
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
          loginModel=LoginData.fromJson(value.data['data']);
          CacheHelper.put(key: 'token', value: value.data["token"]);
          CacheHelper.put(key: 'name', value: loginModel.name);
          CacheHelper.put(key: 'email', value: loginModel.email);


        // showToast(message: value.data['message'], color: secondaryColor);
print("sucessss");
        emit(SignupSuccess());
      });
    } on DioError catch (e) {
      print(e.response);

      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(SignupError(e));
    }
  }

}