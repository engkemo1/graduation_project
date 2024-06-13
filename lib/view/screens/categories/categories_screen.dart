import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/view/screens/categories/sub_categories_screen.dart';

import '../../../view_model/cubit/fav_cubit/fav_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_state.dart';
import '../Notification/notification_screen.dart';
import 'details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeMainState>(
          listener: (BuildContext context, HomeMainState state) async {},
          builder: (BuildContext context, state) {
            var cubit = HomeCubit.get(context);
            var eventsListData = searchController.text.isEmpty?cubit.eventsListData:cubit.eventsListSearch;
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
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
                        onChanged: (value){
                          cubit.searchEvent(value);
                          setState(() {

                          });
                        },
                        controller:searchController ,
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
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cubit.categoryList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                HomeCubit.get(context)
                                    .getSubSpecificCategories(cubit
                                        .categoryList[index].sId
                                        .toString())
                                    .then((value) {
                                  List<EventsData> list = [];
                                  eventsListData.forEach((e) {
                                    if (e.category ==
                                        cubit.categoryList[index].sId) {
                                      list.add(e);
                                      setState(() {});
                                    }
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SubCategoriesScreen(
                                                data: value,
                                                eventsData: list,
                                              )));
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding:
                                    const EdgeInsets.only(left: 8, right: 15),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFFE4C1),
                                    borderRadius: BorderRadius.circular(30),
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white70),
                                      child: Image.network(
                                        cubit.categoryList[index].image
                                            .toString(),
                                        fit: BoxFit.contain,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          // Your error widget here
                                          return Image.asset(
                                            "assets/icons/logo.png",
                                            height: 20,
                                            width: 30,
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      cubit.categoryList[index].name.toString(),
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
                          return GestureDetector(
                            onTap: (){
                              bool isFav = false;
                              FavCubit()
                                  .getFavourite()
                                  .then((onValue) {
                                isFav = onValue
                                    .contains(eventsListData[index].sId)
                                    ? true
                                    : false;

                                print(isFav);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailsScreen(
                                          eventsData:
                                          eventsListData[index],
                                          isFav: isFav,
                                        )));
                              });
                            },
                            child: SizedBox(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    child: Image.network(
                                      eventsListData[index].imageCover
                                          .toString(),
                                      height: 170,
                                      width: 300,
                                      errorBuilder: (context, e, o) =>
                                          Image.asset(
                                        'assets/images/sp.png',
                                        height: 170,
                                        width: 300,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Text(
                                      eventsListData[index].title
                                          .toString(),
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
                                        rating:eventsListData[index].rate==null?0.0:eventsListData[index].rate!.toDouble(),
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
                        itemCount: eventsListData.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 3,
                            childAspectRatio: 0.55
                            ,
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
