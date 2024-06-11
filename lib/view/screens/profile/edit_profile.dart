import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_cubit.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_state.dart';
import 'package:graduation_project/view_model/database/local.dart';
import 'package:image_picker/image_picker.dart';

import '../../../view_model/cubit/home_cubit/home_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

  // This is the image picker
  final _picker = ImagePicker();

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
          child: BlocConsumer<LoginCubit, LoginMainState>(
              listener: (BuildContext context, LoginMainState state) async {
            if (state is UpdateLoginLoadingState) {
              SmartDialog.showLoading();
              await Future.delayed(const Duration(seconds: 2));
              SmartDialog.dismiss();
            }
          }, builder: (BuildContext context, state) {
            var cubit = LoginCubit.get(context);
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context,cubit.image==''?null:cubit.image);
                          setState(() {

                          });
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
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(_image!))
                              : CacheHelper.get(key: "image")!=null?CircleAvatar(
                            radius: 70,
                            backgroundImage:NetworkImage(CacheHelper.get(key: "image")) ):const CircleAvatar(
                                  radius: 70,
                                  backgroundImage:
                                      AssetImage("assets/images/person.jpg"),
                                ),
                          Positioned(
                              bottom: 10,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  _openImagePicker();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffDE442F)),
                                  child: const Icon(
                                    Icons.linked_camera_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            CacheHelper.get(key: "name"),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          // const Text(
                          //   "Nasr City,Cairo",
                          //   style: TextStyle(
                          //       color: Colors.grey, fontWeight: FontWeight.w500),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 0.8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Icon(
                              Icons.email_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        CacheHelper.get(key: "email"),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: ()async {
                        await cubit.editProfile(CacheHelper.get(key: "email"),
                              CacheHelper.get(key: "name"), _image!.path);
                        setState(() {
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(redLevelColor)),
                      child: const Center(
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ))
                  // Row(
                  //   children: [
                  //     Card(
                  //       color: Colors.white,
                  //       elevation: 0.8,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50)),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Center(
                  //           child: Icon(
                  //             Icons.phone,
                  //             size: 30,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     const Text(
                  //       "01012345676",
                  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   children: [
                  //     Card(
                  //       color: Colors.white,
                  //       elevation: 0.8,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(50)),
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Center(
                  //             child: Image.asset(
                  //           "assets/icons/date.png",
                  //           height: 30,
                  //         )),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8,
                  //     ),
                  //     const Text(
                  //       "Sep/20/2002",
                  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  //     )
                  //   ],
                  // ),
                  ,
                  SizedBox(
                    height: 10,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: GestureDetector(
                      onTap: () {
                        CacheHelper.removeData(key: 'token');
                        CacheHelper.removeData(key: 'name');
                        CacheHelper.removeData(key: 'role');
                        CacheHelper.removeData(key: 'Booking');
                        if (CacheHelper.get(key: "image") != null) {
                          CacheHelper.removeData(key: 'image');
                        }

                        CacheHelper.removeData(key: 'email');

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.red,
                          ),
                          Text(
                            "  LogOut",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
