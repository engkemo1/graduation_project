import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/admin/category/widget/add_category_widget.dart';
import 'package:graduation_project/view/screens/admin/category/widget/category_widget.dart';
import 'package:graduation_project/view/screens/admin/news/widget/add_news_widget.dart';
import 'package:graduation_project/view/screens/admin/news/widget/all_news_widget.dart';
import 'package:graduation_project/view/screens/admin/sub_category/widget/add_sub_category_widget.dart';
import 'package:graduation_project/view/screens/admin/sub_category/widget/sub_category_widget.dart';

class SubCategoryAdminScreen extends StatelessWidget {
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
          title: const Text('Admin Sub Categories '),
          bottom: const TabBar(
            indicatorColor: redLevelColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.category,
                  color: redLevelColor,
                ),
                text: "Sub Categories",
              ),
              Tab(
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: redLevelColor,
                  ),
                  text: "Add Sub Category"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SubCategoryWidget(), // Replace with your content widget for tab 1
            AddSubCategoryScreen()
          ],
        ),
      ),
    );
  }
}
