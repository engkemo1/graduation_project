abstract class LoginMainState {}

class LoginMainInitialState extends LoginMainState{}
class LoginLoadingState extends LoginMainState{}
class LoginSuccessState extends LoginMainState{}

class LoginErrorState extends LoginMainState{
  final  error;

  LoginErrorState(this.error);
}



class UpdateLoginLoadingState extends LoginMainState{}
class UpdateLoginSuccessState extends LoginMainState{}

class UpdateLoginErrorState extends LoginMainState{
  final  error;

  UpdateLoginErrorState(this.error);
}