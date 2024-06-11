import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/news_model.dart';
import 'package:http_parser/http_parser.dart';
import '../../database/local.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsMainState> {
  NewsCubit() : super(NewsMainInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<NewsData> newsList = [];
  List<NewsData> newsListSearch = [];

  getNews() async {
    emit(NewsLoadingState());
    try {
      await DioHelper.getData(
        url: "$baseUrl$news",
      ).then((value) {
        newsList = (value.data["data"] as List)
            .map((e) => NewsData.fromJson(e))
            .toList();
        print(newsList);
        emit(NewsSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(NewsErrorState(e));
    }
  }

  Future removeNews(String id) async {
    try {
      await DioHelper.deleteData(
              url: "$baseUrl$news/$id", token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("Removed Successfully");
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  Future addNews(NewsData newsDATA) async {
    print(newsDATA.toJson());

    try {
      FormData formData = FormData.fromMap({
        "name": newsDATA.name,
        "description": newsDATA.description,
        "date": newsDATA.createdAt,
        "newsImage": await MultipartFile.fromFile(
          newsDATA.image!,
          filename: "upload.jpg",
          contentType: new MediaType("image", "jpeg"),
        ),
      });
      await DioHelper.postData(
              url: "$baseUrl$news",
              data: formData,
              token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("News Added Successfully ");

        print(value.data);
      });
    } on DioError catch (e) {
      print(e.response!);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  void searchNews(String name) {
    name = name.toLowerCase();
    newsListSearch = newsList.where((search) {
      var searchTitle = search.name!.toString().toLowerCase();
      print(searchTitle.contains(name));
      return searchTitle.contains(name);
    }).toList();
    if (name == "") {
      newsListSearch.clear();
    } else {}
    emit(state);
  }
}
