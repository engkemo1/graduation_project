
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/news_model.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'news_state.dart';


class NewsCubit extends Cubit<NewsMainState> {
  NewsCubit() : super(NewsMainInitialState());

  static  NewsCubit get(context) => BlocProvider.of(context);
  List<NewsData> eventsList =[];
  getNews(

      ) async {
    emit(NewsLoadingState());
    try {

      await DioHelper
          .getData(url: "$baseUrl$news",

      )
          .then((value) {
        eventsList=
            (value.data["data"] as List).map((e) => NewsData.fromJson(e)).toList();
        print(eventsList);
        emit(NewsSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(NewsErrorState(e));
    }
  }



}
