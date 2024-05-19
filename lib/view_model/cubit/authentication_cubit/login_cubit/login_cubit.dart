
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';


class LoginCubit extends Cubit<LoginMainState> {
  LoginCubit() : super(LoginMainInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


}
