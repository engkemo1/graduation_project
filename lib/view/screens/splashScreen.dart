import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/view/screens/home_screen/home_screen.dart';
import 'package:graduation_project/view/screens/main_screen.dart';
import 'package:graduation_project/view/screens/on_bording_screen.dart';
import 'package:graduation_project/view_model/database/local.dart';
import 'package:introduction_screen/introduction_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/icons/logo.png"),
      nextScreen:  CacheHelper.get(key: "token")!=null?MainScreen():OnBoardingPage(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
