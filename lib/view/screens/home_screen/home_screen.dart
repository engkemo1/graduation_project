import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/models/events_model.dart';
import 'package:graduation_project/view/screens/Notification/notification_screen.dart';
import 'package:graduation_project/view/screens/categories/details_screen.dart';
import 'package:graduation_project/view/screens/home_screen/filter_screen.dart';
import 'package:graduation_project/view_model/cubit/cart_cubit/cart_state.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:intl/intl.dart';

import '../../../view_model/cubit/fav_cubit/fav_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_state.dart';
import '../categories/sub_categories_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeMainState>(
        listener: (BuildContext context, HomeMainState state) async {
      if (state is CategoryLoadingState) {
        SmartDialog.showLoading();
        await Future.delayed(const Duration(seconds: 2));
        SmartDialog.dismiss();
      }
    }, builder: (BuildContext context, state) {
      var cubit = HomeCubit.get(context);
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      width: 150,
                      height: 40,
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
                const SizedBox(
                  height: 15,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Find events near",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    )),
                const SizedBox(
                  height: 8,
                ),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Egypt,Cairo",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: searchController,
                    onChanged: (val) {
                      cubit.searchEvent(val);
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "What are you looking for...",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        prefixIcon: const Icon(
                          Icons.search,
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
                  height: 34,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FilterScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 34,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.3))),
                        child: Image.asset("assets/icons/filter.png"),
                      ),
                    ),
                    ...List.generate(cubit.categoryList.length, (index) {
                      return GestureDetector(
                        onTap: () {
                       List<EventsData> list= [];
cubit.eventsListData.forEach((e){
  if(e.category==cubit.categoryList[index].sId){
    list.add(e);
    setState(() {

    });
  }

});
                          HomeCubit.get(context)
                              .getSubSpecificCategories(
                                  cubit.categoryList[index].sId.toString())
                              .then((value) {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SubCategoriesScreen(
                                      eventsData: list,
                                          data: value,
                                        )));
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3))),
                          child: Center(
                            child: Text(
                              cubit.categoryList[index].name.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                  ]),
                ),
                const SizedBox(height: 23),
                const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Upcoming Events",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var eventsListData = searchController.text.isEmpty
                          ? cubit.eventsListData[index]
                          : cubit.eventsListSearch[index];
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
                                  eventsListData.imageCover??"",
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
                                flex: 4,
                                child: Column(
                                  children: [
                                    Expanded(child: StarRating(
                                        rating:eventsListData.rate==null?0.0:eventsListData.rate!.toDouble(),
                                        size: 15,
                                        allowHalfRating: false,
                                        onRatingChanged: (rating){}
                                    ),),
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
                    itemCount: searchController.text.isEmpty
                        ? cubit.eventsListData.length
                        : cubit.eventsListSearch.length,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
