import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/database/local.dart';
import '../../database/network/dio_helper.dart';
import '../../database/network/endpoints.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingMainState> {
  BookingCubit() : super(BookingMainInitialState());

  static BookingCubit get(context) => BlocProvider.of(context);

  // List<BookingData> bookingList =[];

  getBookingData(String id) async {
    emit(BookingLoadingState());
    try {
      await DioHelper.getData(
              url: "$baseUrl$get_all_booking",
              token: CacheHelper.get(key: "token"))
          .then((value) {
        // bookingList=
        //     (value.data["data"] as List).map((e) => BookingData.fromJson(e)).toList();
        emit(BookingSuccessState());
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      emit(BookingErrorState(e));
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }

  addBooking(
    String type,
    String date,
    int seatNumber,String id
  ) async {

    try {
      await DioHelper.postData(
          url: "https://entertainia.onrender.com/api/v1/booking?eventId=$id",
          token: CacheHelper.get(key: "token"),
          data: {
            "type": type,
            "date": date,
            "seatnumber": seatNumber
          }).then((value) async{
        SmartDialog.showToast("Added Successfully");
       await CacheHelper.put(key: "Booking", value: (int.tryParse(CacheHelper.get(key: "Booking").toString())!+1).toString());
emit(state);
        // bookingList=
        //     (value.data["data"] as List).map((e) => BookingData.fromJson(e)).toList();
      });
    } on DioError catch (e) {
      print(e.response);
      SmartDialog.showToast(e.response!.data["message"]);
      // showToast(message: e.response!.data['message'], color: Colors.red);
    }
  }
}
