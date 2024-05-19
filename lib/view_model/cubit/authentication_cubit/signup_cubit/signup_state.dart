abstract class SignupState {}

class intiStateSignup extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {
  final error;
  SignupError(this.error);
}


class AreaLoading extends SignupState {}

class AreaSuccess extends SignupState {}

class AreaError extends SignupState {
  final error;
  AreaError(this.error);
}

class ChangeCountrySuccess extends SignupState {}

class ChangeGradeSuccess extends SignupState {}