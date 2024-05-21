abstract class CartMainState {}

class CartMainInitialState extends CartMainState{}
class AddLoadingState extends CartMainState{}
class AddSuccessState extends CartMainState{}

class AddErrorState extends CartMainState{
  final  error;

  AddErrorState(this.error);
}


class GetLoadingState extends CartMainState{}
class GetSuccessState extends CartMainState{}

class GetErrorState extends CartMainState{
  final  error;

  GetErrorState(this.error);
}



class RemoveLoadingState extends CartMainState{}
class RemoveSuccessState extends CartMainState{}

class RemoveErrorState extends CartMainState{
  final  error;

  RemoveErrorState(this.error);
}
