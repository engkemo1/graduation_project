import 'package:flutter/material.dart';

import '../../../constants.dart';

class FavouritesNoneWidget extends StatelessWidget {
  const FavouritesNoneWidget({super.key});

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
                  const Text(
                    "Favourite",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset("assets/images/none.png"),
              const Align(
                alignment: Alignment.center,
                child: Text("No favourite found",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text("Like an event to found it later and receive notifications before it sells out",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.grey),textAlign: TextAlign.center,),
              ),
              InkWell(
                onTap: () {

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
