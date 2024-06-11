
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../models/login_model.dart';
import '../../../../view/screens/admin/admin_home_screen.dart';
import '../../../../view/screens/main_screen.dart';
import '../../../database/local.dart';
import '../../../database/network/dio_helper.dart';
import 'login_state.dart';


class LoginCubit extends Cubit<LoginMainState> {
  LoginCubit() : super(LoginMainInitialState());
  LoginData loginModel=LoginData() ;
String image="";
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
print(loginModel.image);
        loginModel=LoginData.fromJson(value.data['data']["result"]);
          CacheHelper.put(key: 'image', value: loginModel.image);

        CacheHelper.put(key: 'token', value: value.data["token"]);
        CacheHelper.put(key: 'name', value: loginModel.name);
        CacheHelper.put(key: 'role', value: loginModel.role);
        CacheHelper.put(key: 'Booking', value: loginModel.booking);
        CacheHelper.put(key: 'email', value: loginModel.email);

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




  editProfile(String email,String name,String image,) async{
    emit(UpdateLoginLoadingState());

    try {
    FormData formData = FormData.fromMap({
      "name":name,
      "email": email,
      "profileImg": await MultipartFile.fromFile(
        image,
        filename: "upload.jpg",
        contentType:  MediaType("image", "jpeg"),
      ),
      
    },);
  await DioHelper
      .putData(url: "https://entertainia.onrender.com/api/v1/users/updateMe",
  data:formData,token: CacheHelper.get(key: "token")

  )
      .then((value) async{
  print(value.data);
  await CacheHelper.put(key: 'image', value: value.data["data"]["profileImg"]);
  image=
  value.data["data"]["profileImg"];
      SmartDialog.showToast("updated successfully");
      emit(UpdateLoginSuccessState());
  });
  } on DioError catch (e) {
  print(e.response);
  SmartDialog.showToast(e.response!.data["message"]);
  // showToast(message: e.response!.data['message'], color: Colors.red);
  emit(UpdateLoginErrorState(e));
  }
}

}

