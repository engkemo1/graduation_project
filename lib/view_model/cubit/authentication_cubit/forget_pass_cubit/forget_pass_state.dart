abstract class ForgetPassMainState {}

class ForgetPassMainInitialState extends ForgetPassMainState{}
class ForgetPassLoadingState extends ForgetPassMainState{}
class ForgetPassSuccessState extends ForgetPassMainState{}

class ForgetPassErrorState extends ForgetPassMainState{
  final  error;

  ForgetPassErrorState(this.error);
}