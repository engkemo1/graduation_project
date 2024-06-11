import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/CategoryModel.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/view_model/database/local.dart';
import 'package:http_parser/http_parser.dart';
import '../../../models/sub_categories_model.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeMainState> {
  HomeCubit() : super(HomeMainInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  List<EventsData> eventsListData = [];
  List<EventsData> eventsListSearch = [];

  List<CategoryData> categoryList = [];
  List<CategoryData> categoryListSearch = [];

  List<SubCategoryData> subCategoryList = [];
  List<SubCategoryData> subCategoryListSearch = [];

  upcomingEvents() async {
    emit(UpComingEventsLoadingState());
    try {
      await DioHelper.getData(
        url: "$baseUrl$events",
      ).then((value) {
        eventsListData = (value.data["data"] as List)
            .map((e) => EventsData.fromJson(e))
            .toList();
        print(eventsListData);
        emit(UpComingEventsSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(UpComingEventsErrorState(e));
    }
  }

  Future removeEvent(String id) async {
    try {
      await DioHelper.deleteData(
              url: "$baseUrl$events/$id", token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("Removed Successfully");
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  Future addEvent(EventsData eventData) async {
    print(eventData.toJson());
    String fileName = eventData.imageCover!.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        "title": eventData.title,
        "description": eventData.description,
        "pricePre": eventData.pricePre,
        "price": eventData.price,
        "seatnumber": eventData.seatnumber,
        "placesLeft": eventData.placesLeft,
        "category": eventData.category,
        "subcategorie": eventData.subcategorie,
        "from": eventData.from,
        "to": eventData.to,
        "location": eventData.location,
        "imageCover": await MultipartFile.fromFile(eventData.imageCover!,
            filename: "upload.jpg",  contentType: new MediaType("image", "jpeg"),),
        "placesLeft": eventData.placesLeft,
      });
      await DioHelper.postData(
              url: "$baseUrl$events",
              data: formData,
              token: CacheHelper.get(key: "token"))
          .then((value) {
            SmartDialog.showToast("Event Added Successfully ");

        print(value.data);
      });
    } on DioError catch (e) {
      print(e.response!);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
    return categoryList;
  }


  void searchEvent(String name) {
    name = name.toLowerCase();
    eventsListSearch = eventsListData.where((search) {
      var searchTitle = search.title!.toString().toLowerCase();
      print(searchTitle.contains(name));
      return searchTitle.contains(name);
    }).toList();
    if (name == "") {
      eventsListSearch.clear();
    } else {}
    emit(state);
  }
///////////////////////////////Categories////////////////////////////////////////
  Future addCategories(CategoryData data) async {
    print(data.toJson());

    try {
      FormData formData = FormData.fromMap({
        "name": data.name,
        "image": await MultipartFile.fromFile(
          data.image!,
          filename: "upload.jpg",
          contentType:  MediaType("image", "jpeg"),
        ),
      });
      await DioHelper.postData(
          url: "$baseUrl$categories",
          data: formData,
          token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("Category Added Successfully ");

        print(value.data);
      });
    } on DioError catch (e) {
      print(e.response!);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }
  Future removeCategory(String id) async {
    try {
      await DioHelper.deleteData(
          url: "$baseUrl$categories/$id", token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("Removed Successfully");
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }
  Future getCategories() async {
    emit(CategoryLoadingState());
    print("object");
    try {
      await DioHelper.getData(
        url: "$baseUrl$categories",
      ).then((value) {
        categoryList = (value.data["data"] as List)
            .map((e) => CategoryData.fromJson(e))
            .toList();
        print(eventsListData);
        emit(CategorySuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      emit(CategoryErrorState(e));
    }
    return categoryList;
  }
  void searchCategory(String name) {
    name = name.toLowerCase();
    categoryListSearch = categoryList.where((search) {
      var searchTitle = search.name!.toString().toLowerCase();
      print(searchTitle.contains(name));
      return searchTitle.contains(name);
    }).toList();
    if (name == "") {
      categoryListSearch.clear();
    } else {}
    emit(state);
  }

//////////////////////////////getSubCategories//////////////////////////////////////
  Future getSubSpecificCategories(String id) async {
    emit(SubCategoryLoadingState());
    try {
      await DioHelper.getData(
        url:
            "https://entertainiaa.onrender.com/api/v1/categories/$id/subcategories",
      ).then((value) {
        subCategoryList = (value.data["data"] as List)
            .map((e) => SubCategoryData.fromJson(e))
            .toList();
        print(subCategoryList);
        emit(SubCategorySuccessState());
        return subCategoryList;
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(SubCategoryErrorState(e));
    }
    return subCategoryList;
  }
  Future getSubCategories() async {
    emit(SubCategoryLoadingState());
    try {
      await DioHelper.getData(
        url:
        "https://entertainiaa.onrender.com/api/v1/subcategories",
      ).then((value) {
        subCategoryList = (value.data["data"] as List)
            .map((e) => SubCategoryData.fromJson(e))
            .toList();
        print(subCategoryList);
        emit(SubCategorySuccessState());
        return subCategoryList;
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
      emit(SubCategoryErrorState(e));
    }
    return subCategoryList;
  }

  Future addSubCategories(CategoryData data) async {
    print(data.toJson());

    try {
      FormData formData = FormData.fromMap({
        "name": data.name,
        "category":data.slug,
        "image": await MultipartFile.fromFile(
          data.image!,
          filename: "upload.jpg",
          contentType:  MediaType("image", "jpeg"),
        ),
      });
      await DioHelper.postData(
          url: "$baseUrl$subcategories",
          data: formData,
          token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("SubCategory item Added Successfully ");

        print(value.data);
      });
    } on DioError catch (e) {
      print(e.response!);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }
  Future removeSubCategory(String id) async {
    try {
      await DioHelper.deleteData(
          url: "$baseUrl$subcategories/$id", token: CacheHelper.get(key: "token"))
          .then((value) {
        SmartDialog.showToast("Removed Successfully");
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  void searchSubCategory(String name) {
    name = name.toLowerCase();
    subCategoryListSearch = subCategoryList.where((search) {
      var searchTitle = search.name!.toString().toLowerCase();
      print(searchTitle.contains(name));
      return searchTitle.contains(name);
    }).toList();
    if (name == "") {
      subCategoryListSearch.clear();
    } else {}
    emit(state);
  }

}
