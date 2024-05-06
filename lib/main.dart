import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graduation_project/view/screens/splashScreen.dart';
import 'package:graduation_project/view_model/database/local.dart';
bool isFirstTime=true;

void main() {
  CacheHelper.put(key: "isFirstTime", value: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}


