import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/models/sub_categories_model.dart';
import 'package:graduation_project/view_model/database/network/endpoints.dart';

import '../../../models/CategoryModel.dart';
import '../../../view_model/cubit/fav_cubit/fav_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_state.dart';
import '../Notification/notification_screen.dart';
import 'details_screen.dart';

class SubCategoriesScreen extends StatefulWidget {
  final List<SubCategoryData> data;
  final List<EventsData> eventsData;

  const SubCategoriesScreen(
      {super.key, required this.data, required this.eventsData});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeMainState>(
          listener: (BuildContext context, HomeMainState state) async {},
          builder: (BuildContext context, state) {
            var cubit = HomeCubit.get(context);
            var eventsData = searchController.text.isEmpty
                ? widget.eventsData
                : cubit.eventsListSearch;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const NotificationScreen()));
                            },
                            child: Image.asset("assets/icons/notify.png")),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          cubit.searchEvent(value);
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "Search",
                            hintStyle: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 35,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.3))),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                cubit.eventsListData.forEach((e) {
                                  if (e.subcategorie ==
                                      widget.data[index].sId) {
                                    eventsData.clear();
                                    eventsData.add(e);
                                    setState(() {});
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFE4C1),
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.data[index].name.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 23),
                    Expanded(
                      child: GridView.builder(
                        itemBuilder: (context, index) {
                          return  GestureDetector(
                            onTap: (){
                              bool isFav = false;
                              FavCubit()
                                  .getFavourite()
                                  .then((onValue) {
                                isFav = onValue
                                    .contains(eventsData[index].sId)
                                    ? true
                                    : false;

                                print(isFav);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailsScreen(
                                          eventsData:
                                          eventsData[index],
                                          isFav: isFav,
                                        )));
                              });
                            },
                            child:  SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    child: Image.network(
                                      height: 150,width: 200,
                                      eventsData[index].imageCover.toString(),
                                      errorBuilder: (context, e, o) =>
                                          Image.asset('assets/images/sp.png',height: 200,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Text(
                                      eventsData[index].title.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      "More details",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Row(children: [
                                    Spacer(),
                                    Expanded(child: StarRating(
                                        rating:eventsData[index].rate==null?0.0:eventsData[index].rate!.toDouble(),
                                        size: 15,
                                        allowHalfRating: false,
                                        onRatingChanged: (rating){}
                                    ),)
                                  ],)

                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: eventsData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 3,
                                childAspectRatio: 0.55,
                                crossAxisSpacing: 15),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
