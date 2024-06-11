import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/admin/news/widget/add_news_widget.dart';
import 'package:graduation_project/view/screens/admin/news/widget/all_news_widget.dart';

class NewsAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Admin News '),
          bottom: const TabBar(
            indicatorColor: redLevelColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.receipt_long,
                  color: redLevelColor,
                ),
                text: "News",
              ),
              Tab(
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: redLevelColor,
                  ),
                  text: "Add News"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllNewsScreen(), // Replace with your content widget for tab 1
            AddNewsScreen()
          ],
        ),
      ),
    );
  }
}
