import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:graduation_project/view_model/cubit/cart_cubit/cart_state.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_cubit.dart';
import 'package:graduation_project/view_model/cubit/news_cubit/news_state.dart';
import 'package:intl/intl.dart';

import '../../../../../view_model/cubit/home_cubit/home_cubit.dart';
import '../../../../../view_model/cubit/home_cubit/home_state.dart';

class AllNewsScreen extends StatefulWidget {
  AllNewsScreen({super.key});

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NewsCubit, NewsMainState>(
          listener: (BuildContext context, NewsMainState state) async {
            if (state is NewsLoadingState) {
              SmartDialog.showLoading();
              await Future.delayed(const Duration(seconds: 2));
              SmartDialog.dismiss();
            }
          }, builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              child: TextField(
                controller: searchController,
                onChanged: (val) {
                  cubit.searchNews(val);
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
                        borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.3))),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var newsListData = searchController.text.isEmpty
                      ? cubit.newsList[index]
                      : cubit.newsListSearch[index];
                  var date1 = DateTime.parse(newsListData.createdAt.toString());

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
                              newsListData.image ?? "",
                              height: 99,
                              width: 100,
                              fit: BoxFit.contain,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
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
                                newsListData.name.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
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
                                    NewsCubit.get(context)
                                        .removeNews(
                                        newsListData.sId.toString())
                                        .then((v) {
                                      NewsCubit.get(context).getNews();
                                    });
                                  },
                                  child: Container(
                                    margin:
                                    EdgeInsets.only(bottom: 10, right: 10),
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Delete",
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
                    ? cubit.newsList.length
                    : cubit.newsListSearch.length,
              ),
            )
          ],
        );
      }),
    );
  }
}
