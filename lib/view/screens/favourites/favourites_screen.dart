import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_cubit.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_state.dart';
import 'package:intl/intl.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                "Favourite",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: BlocConsumer<FavCubit, FavMainState>(
              listener: (BuildContext context, FavMainState state) async {
            if (state is FavLoadingState) {
              SmartDialog.showLoading();
              await Future.delayed(const Duration(seconds: 2));
              SmartDialog.dismiss();
            }
          }, builder: (context, state) {
            var cubit = FavCubit.get(context);
            return ListView.separated(
              itemCount: cubit.favData.length,
              itemBuilder: (context, index) {
                bool isFav = true;
                var date1 =
                    DateTime.parse(cubit.favData[index].from.toString());
                var monthName = DateFormat('MMMM').format(date1);
                var time = DateFormat('hh:mm a').format(date1);
                return cubit.favData.isNotEmpty
                    ? Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.loose,
                        children: [
                          Card(
                            elevation: 0.8,
                            color: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: Image.network(
                                        cubit.favData[index].imageCover
                                            .toString(),
                                        errorBuilder: (context, o, r) {
                                          return Image.asset(
                                              'assets/icons/logo.png');
                                        },
                                      )),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 5),
                                        child: Text(
                                          cubit.favData[index].title.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "${date1.day},$monthName,${date1.year}",
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          time,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${cubit.favData[index].price}\$",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: -10,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.3)),
                              child: FavoriteButton(
                                iconSize: 45.0,
                                isFavorite: isFav,
                                iconDisabledColor: Colors.white,
                                valueChanged: (isFavorite) {
                                  if (isFav == false) {
                                    FavCubit().addFavourite(
                                        cubit.favData[index].sId.toString(),
                                        context);
                                    setState(() {
                                      isFav = true;
                                    });
                                  } else {
                                    FavCubit().deleteFavourite(
                                        cubit.favData[index].sId.toString(),
                                        context);
                                    setState(() {
                                      isFav = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "Favourite Events Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 20,
                );
              },

              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Row(
              //     children: [
              //       Image.asset("assets/icons/date.png"),
              //       const Text(
              //         "   Monday,sep 21",
              //         style: TextStyle(
              //             color: Color(0xff2C2C2C),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 16),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20,),
              // ...List.generate(2, (index) =>
              //     Card(
              //       elevation: 0.8,
              //       color: Colors.white,
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Expanded(
              //             child: ClipRRect(
              //               borderRadius: const BorderRadius.only(
              //                   bottomRight: Radius.circular(10),
              //                   bottomLeft: Radius.circular(10)),
              //               child: Image.asset(
              //                   'assets/images/Rectangle 8.png'),
              //             ),
              //           ),
              //           Expanded(flex: 2,
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment
              //                   .start,
              //               children: [
              //                 const Padding(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 8.0, vertical: 5),
              //                   child: Text(
              //                     "Reserve your place in the next tennis tournament between Egypt and America  ",
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontWeight: FontWeight.w600,
              //                         fontSize: 14),
              //                   ),
              //                 ),
              //                 const Padding(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 8.0),
              //                   child: Text(
              //                     "10,JUIN,2024",
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 12),
              //                   ),
              //                 ),
              //                 const Padding(
              //                   padding: EdgeInsets.symmetric(
              //                       horizontal: 8.0),
              //                   child: Text(
              //                     "10:00 PM",
              //                     style: TextStyle(
              //                         color: Colors.grey,
              //                         fontWeight: FontWeight.w500,
              //                         fontSize: 12),
              //                   ),
              //                 ),
              //                 Align(
              //                   alignment: Alignment.bottomRight,
              //                   child: Container(
              //                     margin: EdgeInsets.all(5),
              //                     height: 30,
              //                     width: 60,
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(
              //                           5),
              //                       color: Colors.red,
              //                     ),
              //                     child: const Center(
              //                       child: Text(
              //                         "25\$",
              //                         style: TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.w600),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ))
            );
          }),
        ),
      ),
    );
  }
}
