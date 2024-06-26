import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view/screens/favourites/Favoiurites_none_widget.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_cubit.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_state.dart';
import 'package:intl/intl.dart';

import '../Notification/notification_screen.dart';

class NewsScreen extends StatefulWidget {
   NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
   TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsMainState>(
        listener: (BuildContext context, NewsMainState state) async {
      if (state is NewsLoadingState) {
        SmartDialog.showLoading();
        await Future.delayed(Duration(seconds: 2));
        SmartDialog.dismiss();
      }
    }, builder: (BuildContext context, state) {
      var data =searchController.text.isEmpty? NewsCubit.get(context).newsList: NewsCubit.get(context).newsListSearch;
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
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
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    onChanged: (val){
                      NewsCubit.get(context).searchNews(val);
                      setState(() {});

                    },
                    controller: searchController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "What are you looking for...",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
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
                const SizedBox(height: 23),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 240,
                      child: Card(
                        elevation: 0.8,
                        color: Colors.white,
                        child: SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    child: Image.network(
                                      data[index].image ?? '',
                                      fit: BoxFit.contain,
                                      width: 120,
                                      errorBuilder: (context, o, e) {
                                        return Image.asset(
                                          'assets/images/Rectangle 64.png',
                                          fit: BoxFit.contain,

                                        );
                                      },
                                    )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(data[index]
                                                  .createdAt
                                                  .toString())),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        data[index].name.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        data[index].description.toString(),
                                        softWrap: true,
                                        maxLines: 5,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "SeeMore",
                                          style: TextStyle(
                                              color: Color(0xff075785),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
