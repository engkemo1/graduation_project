
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view/screens/authentication/verify_code_screen.dart';

import '../../../../view/screens/authentication/create_new_password_screen.dart';
import '../../../../view/screens/authentication/success_password_screen.dart';
import '../../../../view/screens/main_screen.dart';
import '../../../database/network/dio_helper.dart';
import '../../../database/network/endpoints.dart';
import 'forget_pass_state.dart';


class ForgetPassCubit extends Cubit<ForgetPassMainState> {
  ForgetPassCubit() : super(ForgetPassMainInitialState());

  static  ForgetPassCubit get(context) => BlocProvider.of(context);

  forgetPass(
      BuildContext context,
      String email,

      ) async {
    emit(ForgetPassLoadingState());

    try {

      await DioHelper
          .postData(url: "$baseUrl$forgotPassword",
        data:
        {
          "email": email,
        }
        ,
      )
          .then((value) {
        print(value.data);

        Navigator.push(context,
            MaterialPageRoute(builder: (_) =>  VerifyCodeScreen(email:email ,)));

        SmartDialog.showToast(value.data["message"]);
        emit(ForgetPassSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(ForgetPassErrorState(e));
    }
  }


  verifyCode(
      BuildContext context,
      String resetCode,
      String email
      ) async {
    emit(ForgetPassLoadingState());

    try {

      await DioHelper
          .postData(url: "$baseUrl$verifyResetCode",
        data:
        {
          "resetCode": resetCode,
        }
        ,
      )
          .then((value) {
        print(value.data);

        Navigator.push(context,
            MaterialPageRoute(builder: (_) =>  CreateNewPasswordScreen(email:email ,)));

        SmartDialog.showToast(value.data["message"]);
        emit(ForgetPassSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(ForgetPassErrorState(e));
    }
  }

  changePass(
      BuildContext context,
      String email,
      String password,

      ) async {
    emit(ForgetPassLoadingState());

    try {

      await DioHelper
          .putData(url: "$baseUrl$resetPassword",
        data:
        {
          "email": email,
          "newPassword":password
        }
        ,
      )
          .then((value) {
        print(value.data);

        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SuccessPasswordScreen()));

        emit(ForgetPassSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(ForgetPassErrorState(e));
    }
  }
}
