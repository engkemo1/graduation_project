
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/CategoryModel.dart';
import 'package:graduation_project/models/EventsModel.dart';
import 'package:graduation_project/view/screens/authentication/verify_code_screen.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'home_state.dart';


class HomeCubit extends Cubit<HomeMainState> {
  HomeCubit() : super(HomeMainInitialState());

  static  HomeCubit get(context) => BlocProvider.of(context);
  List<EventsData> eventsList =[];

  List<CategoryData> categoryList =[];
  List<CategoryData> subCategoryList =[];

  upcomingEvents(

      ) async {
    emit(UpComingEventsLoadingState());
print("object");
    try {

      await DioHelper
          .getData(url: "$baseUrl$events",

      )
          .then((value) {
        eventsList=
                (value.data["data"] as List).map((e) => EventsData.fromJson(e)).toList();
        print(eventsList);
        emit(UpComingEventsSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(UpComingEventsErrorState(e));
    }
  }

  getCategories(

      ) async {
    emit(CategoryLoadingState());
    print("object");
    try {

      await DioHelper
          .getData(url: "$baseUrl$categories",

      )
          .then((value) {
        categoryList=
            (value.data["data"] as List).map((e) => CategoryData.fromJson(e)).toList();
        print(eventsList);
        emit(CategorySuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(CategoryErrorState(e));
    }
  }
  getSubCategories(

      ) async {
    emit(SubCategoryLoadingState());
    try {

      await DioHelper
          .getData(url: "$baseUrl$subcategories",

      )
          .then((value) {
        subCategoryList=
            (value.data["data"] as List).map((e) => CategoryData.fromJson(e)).toList();
        print(eventsList);
        emit(SubCategorySuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(SubCategoryErrorState(e));
    }
  }

}
