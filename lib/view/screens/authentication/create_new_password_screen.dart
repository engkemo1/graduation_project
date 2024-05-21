import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';
import 'package:graduation_project/view/screens/authentication/signUp.dart';
import 'package:graduation_project/view/screens/authentication/success_password_screen.dart';

import '../../../constants.dart';
import '../../../view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_cubit.dart';
import '../../../view_model/cubit/authentication_cubit/forget_pass_cubit/forget_pass_state.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
   CreateNewPasswordScreen({super.key, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController passController = TextEditingController();

  final TextEditingController confirmPassController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

   String _confirmPasswordValidator(String value) {
     if (value.isEmpty) {
       return 'Please confirm your password';
     } else if (passController.text != value) {
       return 'Passwords do not match';
     }
     return "";
   }

  bool obscureText = true;

   bool obscureText2 = true;

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
                      "Create New Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    obscureText: obscureText,
                    controller: passController,
                    validator:(value) => _confirmPasswordValidator(value!),
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
                          icon: obscureText== true
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
                  const  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: obscureText2,
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

                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: obscureText2 == true
                              ? Image.asset(
                            "assets/icons/eye.png",
                            color: Color(0xff666666),
                          )
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureText2 = !obscureText2;
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
                  const  SizedBox(
                    height: 16,
                  ),
              SizedBox(height: MediaQuery.of(context).size.height*0.3,),
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
                          return  Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              if(_formKey.currentState!.validate()){
                                ForgetPassCubit.get(context).changePass(
                                    context,
                                  widget.email,
                                    passController.text);}
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
                                  "Create New Password ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
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
