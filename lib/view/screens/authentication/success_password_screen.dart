
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';

import '../../../constants.dart';

class SuccessPasswordScreen extends StatelessWidget {
  const SuccessPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

const Spacer(flex: 2,),
            Image.asset("assets/icons/image 13.png"),
            const Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: Center(
                child: Text(
                  "The password has been changed successfully",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),textAlign: TextAlign.center,
                ),

              ),
            ),
            const Spacer(flex: 5,),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  LoginScreen()));
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
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1,),

          ],
        ),
      ),
    );
  }
}
