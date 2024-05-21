abstract class BookingMainState {}

class BookingMainInitialState extends BookingMainState{}
class BookingLoadingState extends BookingMainState{}
class BookingSuccessState extends BookingMainState{}

class BookingErrorState extends BookingMainState{
  final  error;

  BookingErrorState(this.error);
}
