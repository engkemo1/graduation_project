import 'package:flutter/material.dart';
import 'package:graduation_project/view/screens/main_screen.dart';

import '../../../constants.dart';

class FavouritesNoneWidget extends StatelessWidget {
  const FavouritesNoneWidget({super.key, required this.text});
final String  text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              Image.asset("assets/images/none.png"),
               Align(
                alignment: Alignment.center,
                child: Text("No ${text} found",
                  style:const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text("Like an event to found it later and receive notifications before it sells out",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.grey),textAlign: TextAlign.center,),
              ),
              InkWell(
                onTap: () {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainScreen()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: redLevelColor),
                  margin: const EdgeInsets.only(
                    left: 70,
                    right: 70,
                    top: 32,
                    bottom: 15,
                  ),
                  child: const Center(
                    child: Text(
                      "Find Event",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
