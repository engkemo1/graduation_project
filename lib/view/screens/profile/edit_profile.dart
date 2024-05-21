import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';
import 'package:image_picker/image_picker.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
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
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_outlined,
                        size: 30,
                      ))
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
                        backgroundImage:
                             FileImage(_image!)

                      ):const CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/images/person.jpg"),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 0,
                          child: InkWell(
                            onTap: (){
_openImagePicker();

                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffDE442F)),
                              child: const Icon(Icons.linked_camera_outlined,size: 30,color: Colors.white,),
                            ),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Kamal Magdy",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Nasr City,Cairo",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
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
                  const Text(
                    "emma123@gmail.com",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
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
                          Icons.phone,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "01012345676",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Image.asset(
                        "assets/icons/date.png",
                        height: 30,
                      )),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    "Sep/20/2002",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
               Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
                  },
                  child:const Row(
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
        ),
      ),
    );
  }
}
