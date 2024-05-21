import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/view/screens/authentication/create_new_password_screen.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';
import 'package:graduation_project/view/screens/authentication/signUp.dart';
import 'package:graduation_project/view/screens/authentication/verify_code_screen.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_state.dart';

import '../../../constants.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Center(
                    child: Text(
                      "Reset Your Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Please enter your email address and we will send you instructions to reset your password",
                      style: TextStyle(
                          color: Color(0xff99999999),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 60,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                  const  SizedBox(
                    height: 16,
                  ),
                  BlocProvider(
                    create: (BuildContext context) {
                      return ForgetPassCubit();
                    },
                    child: BlocConsumer<ForgetPassCubit, ForgetPassMainState>(
                        builder: (BuildContext context, state) {
                          return InkWell(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              ForgetPassCubit.get(context).forgetPass(
                                context,
                                emailController.text,
                              );}

                          },
                          child: Container(
                            height: 47,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: redLevelColor),
                            margin: const EdgeInsets.only(
                              left: 14,
                              right: 14,
                              top: 20,
                              bottom: 15,
                            ),
                            child: const Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }, listener: (BuildContext context, ForgetPassMainState state) async{
                      if (state is ForgetPassLoadingState) {
                        SmartDialog.showLoading();
                        await Future.delayed(Duration(seconds: 2));
                        SmartDialog.dismiss();
                      }

                    },
                    ),
                  ),
                   Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>  LoginScreen()));
                      },
                      child:const Text(
                        "Back to login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
