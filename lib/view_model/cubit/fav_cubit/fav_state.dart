abstract class FavMainState {}

class FavMainInitialState extends FavMainState{}
class FavLoadingState extends FavMainState{}
class FavSuccessState extends FavMainState{}

class FavErrorState extends FavMainState{
  final  error;

  FavErrorState(this.error);
}
