import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/Notification/notification_screen.dart';
import 'package:graduation_project/view/screens/categories/details_screen.dart';
import 'package:graduation_project/view_model/cubit/home_cubit/home_cubit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../models/events_model.dart';
import '../../../view_model/cubit/fav_cubit/fav_cubit.dart';
import '../../../view_model/cubit/home_cubit/home_state.dart';
import '../favourites/Favoiurites_none_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

double _priceValue = 0.0;
List<EventsData> filterList = [];

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeMainState>(
        listener: (BuildContext context, HomeMainState state) async {},
        builder: (BuildContext context, state) {
          var cubit = HomeCubit.get(context);
          var eventsListData2 = searchController.text.isEmpty
              ? filterList.isEmpty
                  ? cubit.eventsListData
                  : filterList
              : cubit.eventsListSearch;
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 80),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                      const Text(
                        "Filter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const FavouritesNoneWidget()));
                          },
                          child: Image.asset("assets/icons/notify.png")),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 55,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          cubit.searchEvent(value);
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
                    SizedBox(height: 15),
                    Row(
                      children:
                          List.generate(cubit.categoryList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            filterList.clear();

                            for (var e in cubit.eventsListData) {
                              if (_priceValue != 0.0) {
                                if (e.category ==
                                        cubit.categoryList[index].sId &&
                                    e.price! <= _priceValue.toInt()) {
                                  filterList.add(e);
                                  print(filterList);
                                  setState(() {});
                                }
                              }else {
                                if (e.category ==
                                    cubit.categoryList[index].sId) {
                                  filterList.add(e);
                                  print(filterList);

                                  setState(() {});
                                }
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Average price",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SfSlider(
                      min: 0,
                      labelPlacement: LabelPlacement.betweenTicks,
                      max: 1000,
                      interval: 20,
                      stepSize: 5,
                      showTicks: false,
                      showLabels: false,
                      edgeLabelPlacement: EdgeLabelPlacement.inside,
                      showDividers: false,
                      tooltipShape: const SfPaddleTooltipShape(),
                      activeColor: redLevelColor,
                      shouldAlwaysShowTooltip: false,
                      tooltipTextFormatterCallback: (d, v) {
                        return "$v\$";
                      },
                      enableTooltip: true,
                      minorTicksPerInterval: 0,
                      onChanged: (dynamic val) {
                        for (var e in cubit.eventsListData) {
                          filterList.clear();
                          if (_priceValue != 0.0) {
                            if (e.price! <= _priceValue.toInt()) {
                              filterList.add(e);
                              setState(() {});
                            }
                          }
                        }
                        setState(() {
                          _priceValue = val;
                        });
                      },
                      value: _priceValue,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {

                          var date1 =
                              DateTime.parse(eventsListData2[index].from.toString());
                          var date2 =
                              DateTime.parse(eventsListData2[index].to.toString());
                          String monthName = DateFormat('MMMM')
                              .format(date1); // Example: 'June'
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
                                      eventsListData2[index].imageCover!,
                                      height: 99,
                                      width: 100,
                                      fit: BoxFit.contain,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        // Your error widget here
                                        return Image.asset(
                                            "assets/icons/logo.png");
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        " ${eventsListData2[index].location} ${eventsListData2[index].title}  ${date1.day}:${date2.day} $monthName ${date1.year}",
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
                                              isFav = onValue.contains(
                                                      eventsListData2[index].sId)
                                                  ? true
                                                  : false;

                                              print(isFav);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          DetailsScreen(
                                                            eventsData:
                                                                eventsListData2[index],
                                                            isFav: isFav,
                                                          )));
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
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
                                                    fontWeight:
                                                        FontWeight.w600),
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
                        itemCount:eventsListData2.length,
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
