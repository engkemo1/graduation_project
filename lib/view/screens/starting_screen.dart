import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';
import 'package:graduation_project/view/screens/authentication/signUp.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 116,
          ),
          const Center(
            child: Text(
              "Lets Get Started",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Center(
            child: Text(
              "We're happy to have you here!",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff99999999)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 31,
          ),
          Image.asset(
            "assets/icons/starting.png",
            height: 216,
            width: 228,
            color: Colors.black,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
            },
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: redLevelColor),
              margin: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 78,
                bottom: 15,
              ),
              child: const Center(
                child: Text(
                  "Continue With Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              margin: const EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logos_google-icon.svg",
                    height: 20,
                    width: 20,
                  ),
                  const Text(
                    "Continue With Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox()
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white),
              margin: const EdgeInsets.only(
                left: 14,
                right: 14,
                bottom: 78,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    "assets/icons/devicon_facebook.svg",
                    height: 20,
                    width: 20,
                  ),
                  const Text(
                    "Continue With Facebook",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox()
                ],
              ),
            ),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
           const   Text("Dont have an account?  ",style: TextStyle(
              color: Color(0xff656565),
              fontWeight: FontWeight.w600,
              fontSize: 15),),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterScreen()));
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
    );
  }
}
