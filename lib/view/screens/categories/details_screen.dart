import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/view/screens/book_screen/book_screen.dart';
import 'package:graduation_project/view_model/cubit/fav_cubit/fav_cubit.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Notification/notification_screen.dart';
import '../main_screen.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.eventsData, required this.isFav});

  final EventsData eventsData;
  bool isFav;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool _isExpanded = false;
  late DateTime date1;
  late DateTime date2;
  String monthName = "JUL";
  String dayName = "Sat";
  String time = "Sat";
  List id = [];

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    date1 = DateTime.parse(widget.eventsData.from.toString());
    date2 = DateTime.parse(widget.eventsData.to.toString());
    monthName = DateFormat('MMMM').format(date1);
    dayName = DateFormat('EEEE').format(date1);
    time = DateFormat('hh:mm a').format(date1);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
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
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationScreen()));
                  },
                  child: Image.asset("assets/icons/notify.png")),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      widget.eventsData.imageCover??'',
                      fit: BoxFit.contain,
                      height: 200,
                      width: double.infinity,
                      errorBuilder: (context, object, s) {
                        return Image.asset(
                          "assets/icons/logo.png",
                          height: 200,
                        );
                      },
                    )),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Center(
                      child: Text(
                        "${widget.eventsData.price}\$",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      "${widget.eventsData.location}, ${widget.eventsData.title} ${date1.day}:${date2.day} $monthName ${date1.year}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 17),
                    )),
                const Spacer(
                  flex: 2,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.1)),
                    child: FavoriteButton(
                      iconSize: 40.0,
                      isFavorite: widget.isFav,
                      iconDisabledColor: Colors.white,
                      valueChanged: (isFavorite) {
                        if (widget.isFav == false) {
                          FavCubit()
                              .addFavourite(widget.eventsData.sId.toString(),context);
                          setState(() {
                            widget.isFav = true;
                          });
                        } else {
                          FavCubit().deleteFavourite(
                              widget.eventsData.sId.toString(),context);
                          setState(() {
                            widget.isFav = false;
                          });
                        }

                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 40,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${date1.day}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          monthName,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        dayName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     const Text(
            //       "Rating",
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Container(
            //       margin: EdgeInsets.all(5),
            //       height: 25,
            //       width: 35,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         color: Colors.red,
            //       ),
            //       child: const Center(
            //         child: Text(
            //           "8.5",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 13,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     const SizedBox(
            //       width: 50,
            //       child: Text(
            //         "Service",
            //         style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: LinearPercentIndicator(
            //         width: 200,
            //         animation: true,
            //         barRadius: Radius.circular(20),
            //         lineHeight: 11.0,
            //         animationDuration: 2500,
            //         percent: 0.8,
            //         linearStrokeCap: LinearStrokeCap.round,
            //         progressColor: redLevelColor,
            //       ),
            //     ),
            //     const Text(
            //       "80.0",
            //       style: TextStyle(
            //           color: Colors.grey,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w600),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            Row(
              children: [
                const SizedBox(
                  width: 50,
                  child: Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: LinearPercentIndicator(
                    width: 200,
                    animation: true,
                    barRadius: Radius.circular(20),
                    lineHeight: 11.0,
                    animationDuration: 2500,
                    percent: widget.eventsData.price! / 1000,
                    linearStrokeCap: LinearStrokeCap.round,
                    progressColor: redLevelColor,
                  ),
                ),
                Text(
                  "${(widget.eventsData.price! / 1000)}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "About this event",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(
                    "${widget.eventsData.description}",
                    maxLines: _isExpanded ? 8 : 5,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: _toggle,
                  child: Text(
                    _isExpanded ? 'See Less' : 'See More',
                    style: const TextStyle(
                        color: redLevelColor,
                        decoration: TextDecoration.underline,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "${widget.eventsData.placesLeft ?? 0} places left",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>  BookScreen(eventsData:widget.eventsData ,)));
              },
              child: Container(
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: redLevelColor),
                margin: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 32,
                  bottom: 15,
                ),
                child: const Center(
                  child: Text(
                    "Book Now",
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
    ));
  }
}
