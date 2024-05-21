import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_state.dart';

class VerifyCodeScreen extends StatefulWidget {
   VerifyCodeScreen({super.key,  this.email});

  String? email;

  @override
  State<VerifyCodeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VerifyCodeScreen> {
  bool _onEditing = true;
  String? _code;

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 20,),
          const Center(
            child: Text(
              "Verify Your Email",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
          ),
          const SizedBox(
            width: 270,
            child: Text(
              "Please enter your coder and we will send you  to reset your password",
              style: TextStyle(
                  color: Color(0xff99999999),
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40,),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Enter your code',
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
            ),
          ),
    BlocProvider(
    create: (BuildContext context) {
    return ForgetPassCubit();
    },
    child: BlocConsumer<ForgetPassCubit, ForgetPassMainState>(
        listener: (BuildContext context, ForgetPassMainState state) async{
          if (state is ForgetPassLoadingState) {
            SmartDialog.showLoading();
            await Future.delayed(Duration(seconds: 2));
            SmartDialog.dismiss();
          }
        },
    builder: (BuildContext context, state) {
    return  Builder(
              builder: (context) {
                return VerificationCode(
                  textStyle: TextStyle(color: Colors.black),
                  fullBorder: true,
                  keyboardType: TextInputType.number,
                  fillColor: Colors.grey.withOpacity(0.2),
                  digitsOnly: true,
                  underlineColor: Colors
                      .transparent,
                  // If this is null it will use primaryColor: Colors.red from Theme
                  length: 6,
                  cursorColor:
                  Colors.blue,
                  // If this is null it will default to the ambient
                  // clearAll is NOT required, you can delete it
                  // takes any widget, so you can implement your design
                  clearAll: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'clear all',
                      style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                          color: Colors.blue[700]),
                    ),
                  ),
                  onCompleted: (String value) {
                    ForgetPassCubit.get(context).verifyCode(
                        context,
                      value,widget.email!
                       );

                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                );
              });})),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _onEditing
                  ? const Text('Please enter full code')
                  : Text('Your code: $_code'),
            ),
          )
        ],
      ),
    );
  }}