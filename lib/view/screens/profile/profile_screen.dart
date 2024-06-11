import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/view/screens/profile/edit_profile.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_cubit.dart';
import 'package:graduation_project/view_model/cubit/authentication_cubit/login_cubit/login_state.dart';
import 'package:intl/intl.dart';

import '../../../view_model/cubit/fav_cubit/fav_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_state.dart';
import '../../../view_model/database/local.dart';
import '../categories/details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeMainState>(
        listener: (BuildContext context, HomeMainState state) async {},
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
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
                      SizedBox(),
                      const Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>const EditProfileScreen())).then((value){

                            image=value;
                            setState(() {

                            });
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocProvider<LoginCubit>(
                    create: (context)=>LoginCubit(),
                    child: BlocConsumer<LoginCubit, LoginMainState>(
                        listener: (BuildContext context, LoginMainState state) async {},
                        builder: (BuildContext context, state) {
                          var cubit = LoginCubit.get(context);
                          return Row(
                          children: [
image != null?  CircleAvatar(
                          radius: 70,
                              backgroundImage:NetworkImage(image))  :
                             CacheHelper.get(key: "image")==null?
                            const CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage("assets/images/person.jpg"),
                            ):CircleAvatar(
                               radius: 70,
                               backgroundImage:NetworkImage(CacheHelper.get(key: "image"))),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  CacheHelper.get(key: "name"),
                                  style:const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  CacheHelper.get(key: "email"),
                                  style: const TextStyle(
                                      color: Colors.grey, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                                           );
                       }
                     ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const  Text(
                            "Booking",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const  SizedBox(
                            height: 10,
                          ),
                          Text(
                            CacheHelper.get(key: "Booking").toString(),
                            style:const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Suggestions For You",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var eventsListData =
                            cubit.eventsListData[index];

                        var date1 =
                        DateTime.parse(eventsListData.from.toString());
                        var date2 = DateTime.parse(eventsListData.to.toString());
                        String monthName =
                        DateFormat('MMMM').format(date1); // Example: 'June'
                        return SizedBox(
                          height: 127,
                          width: 343,
                          child: Card(
                            elevation: 0.8,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Image.network(
                                    eventsListData.imageCover!,
                                    height: 99,
                                    width: 100,
                                    fit: BoxFit.contain,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      // Your error widget here
                                      return Image.asset("assets/icons/logo.png");
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      " ${eventsListData.location} ${eventsListData.title}  ${date1.day}:${date2.day} $monthName ${date1.year}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          bool isFav = false;
                                          FavCubit()
                                              .getFavourite()
                                              .then((onValue) {
                                            isFav = onValue
                                                .contains(eventsListData.sId)
                                                ? true
                                                : false;

                                            print(isFav);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => DetailsScreen(
                                                      eventsData:
                                                      eventsListData,
                                                      isFav: isFav,
                                                    )));
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10, right: 10),
                                          height: 40,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.red,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Join",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount:
                          cubit.eventsListData.length
                    ),
                  )

                  // Expanded(
                  //   child: ListView.separated(
                  //       itemBuilder: (context, index) {
                  //         return Row(
                  //           children: [
                  //             Expanded(
                  //               flex: 2,
                  //               child: Stack(
                  //                 children: [
                  //                   Image.asset(
                  //                     "assets/images/image 15.png",
                  //                     width: 143,
                  //                   ),
                  //                   Positioned(
                  //                     bottom: 10,
                  //                     left: 30,
                  //                     child: Container(
                  //                       alignment: Alignment.center,
                  //                       padding: const EdgeInsets.symmetric(
                  //                           horizontal: 10, vertical: 5),
                  //                       decoration: BoxDecoration(
                  //                           borderRadius: BorderRadius.circular(10),
                  //                           color: Colors.black54),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           "77 Reviews",
                  //                           style: TextStyle(
                  //                               fontWeight: FontWeight.w500,
                  //                               fontSize: 10,
                  //                               color: Colors.white),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //               flex: 3,
                  //               child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.start,
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   const Text(
                  //                     "Vox Cinema Cairo",
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w700,
                  //                         fontSize: 16,
                  //                         color: Colors.black),
                  //                   ),
                  //                   const Text(
                  //                     "Located in City Stars, New Cairo. It includes 11 screens, including an IMAX screen.",
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.w500,
                  //                         fontSize: 13,
                  //                         color: Colors.black54),
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 5,
                  //                   ),
                  //                   const Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.location_on_sharp,
                  //                         color: Color(0xff3EC3FF),
                  //                         size: 15,
                  //                       ),
                  //                       Text(
                  //                         " 5 km away from you",
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w500,
                  //                             fontSize: 10,
                  //                             color: Colors.black54),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   RatingBar.builder(
                  //                     initialRating: 3,
                  //                     minRating: 1,
                  //                     itemSize: 20,
                  //                     direction: Axis.horizontal,
                  //                     allowHalfRating: true,
                  //                     itemCount: 5,
                  //                     itemPadding: const EdgeInsets.symmetric(
                  //                         horizontal: 1.0),
                  //                     itemBuilder: (context, _) => const Icon(
                  //                       Icons.star,
                  //                       color: Colors.amber,
                  //                     ),
                  //                     onRatingUpdate: (rating) {
                  //                       print(rating);
                  //                     },
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //       separatorBuilder: (context, index) {
                  //         return const SizedBox(
                  //           height: 10,
                  //         );
                  //       },
                  //       itemCount: 5),
                  // )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
