import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/cubit/notification_cubit/norification_cubit.dart';
import 'package:graduation_project/view_model/cubit/notification_cubit/notification_state.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<NotificationCubit, NotificationMainState>(
          listener: (BuildContext context, NotificationMainState state) async {
            if (state is NotificationLoadingState) {
              SmartDialog.showLoading();
              await Future.delayed(const Duration(seconds: 2));
              SmartDialog.dismiss();
            }
          }, builder: (BuildContext context, state) {
        var cubit = NotificationCubit.get(context);
        return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
            child: ListView(
              children: [
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
                      "Notifications",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    const SizedBox()
                  ],
                ),
                const SizedBox(height: 40,),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
            ...List.generate(cubit.notificationModelList.length, (index) {
             Duration  date=DateTime.parse(cubit.notificationModelList[index].createdAt.toString()).difference(DateTime.now());
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/images/person.jpg"),
                    ),
                    const   SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.notificationModelList[index].notification.toString()  ,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const   SizedBox(
                            height: 4,
                          ),
                          // Text(
                          //   "Emma Lewis follow the Cairo Art Festival at 6:30 pm",
                          //   style: TextStyle(
                          //       color: Colors.grey, fontWeight: FontWeight.w500),
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 50,),
                            Text(
                              "${date.inHours.abs()}h",
                              style: const TextStyle(color: Colors.grey,
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],

                        )),

                  ],
                ),
              );
            }       ),

              ],
            ),
          );
        }
      ),
    ));
  }
}
