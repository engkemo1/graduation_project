import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/view/screens/authentication/forget_password_screen.dart';
import 'package:graduation_project/view/screens/authentication/signUp.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_cubit.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_state.dart';

import '../../../constants.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

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

                  const SizedBox(
                    height: 70,
                  ),
                  const Center(
                    child: Text(
                      "Hello Again!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Welcome Back,You have been missed",
                      style: TextStyle(
                          color: Color(0xff99999999),
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  TextFormField(controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      }
                      // Regex for email validation
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
                          r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
                          r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(
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
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passController,
                    obscureText: obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      String pattern =
                          r'^(?=.*?[0-9]).{8,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'Enter a valid password (Min. 8 characters)';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: obscureText == true
                              ? Image.asset(
                            "assets/icons/eye.png",
                            color: Color(0xff666666),
                          )
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
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
                  const SizedBox(
                    height: 16,
                  ),
                   Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>  ForgetPasswordScreen()));
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (BuildContext context) {
                      return LoginCubit();
                    },
                    child: BlocConsumer<LoginCubit, LoginMainState>(
                        builder: (BuildContext context, state) {
                          return GestureDetector(
                          onTap: () {
                            if(_formKey.currentState!.validate()){
                              LoginCubit.get(context).login(
                                context,
                                emailController.text,
                                passController.text,
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
                              top: 32,
                              bottom: 15,
                            ),
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      }, listener: (BuildContext context, LoginMainState state)async {
                      if (state is LoginLoadingState) {
                        SmartDialog.showLoading();
                        await Future.delayed(Duration(seconds: 2));
                      }
                      if(state is LoginSuccessState|| state is LoginErrorState){
                        SmartDialog.dismiss();

                      }
                    },
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Row(
                    children: [
                      Spacer(),
                      Expanded(child: Divider()),
                      Text("     Or     "),
                      Expanded(child: Divider()),
                      Spacer(),

                    ],
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 47,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.grey),
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Colors.white),
                  //     margin: const EdgeInsets.only(
                  //       left: 14,                    top: 20,
                  //
                  //       right: 14,
                  //       bottom: 15,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         SvgPicture.asset(
                  //           "assets/icons/logos_google-icon.svg",
                  //           height: 20,
                  //           width: 20,
                  //         ),
                  //         const Text(
                  //           "Continue With Google",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 16),
                  //         ),
                  //         SizedBox()
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 47,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.grey),
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Colors.white),
                  //     margin: const EdgeInsets.only(
                  //       left: 14,
                  //       right: 14,
                  //       bottom: 50,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         SvgPicture.asset(
                  //           "assets/icons/devicon_facebook.svg",
                  //           height: 20,
                  //           width: 20,
                  //         ),
                  //         const Text(
                  //           "Continue With Facebook",
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 16),
                  //         ),
                  //         const SizedBox()
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const   Text("Dont have an account?  ",style: TextStyle(
                          color: Color(0xff656565),
                          fontWeight: FontWeight.w600,
                          fontSize: 15),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) =>  RegisterScreen()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: redLevelColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
