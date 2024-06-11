import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/admin/category/category_admin_screen.dart';
import 'package:graduation_project/view/screens/admin/events/events_screen.dart';
import 'package:graduation_project/view/screens/admin/news/news_admin_screen.dart';
import 'package:graduation_project/view/screens/admin/sub_category/sub_category_admin_screen.dart';
import 'package:graduation_project/view/screens/authentication/login.dart';

import '../../../view_model/database/local.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset("assets/icons/logoAdmin.png"),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ExpansionTile(
                shape: const Border(), // This removes the default border

                leading: const Icon(
                  Icons.dashboard_customize,
                  color: redLevelColor,
                ),

                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => EventsScreen()));
                    },
                    trailing: const Icon(
                      Icons.ads_click_outlined,
                      color: Colors.redAccent,
                    ),
                    leading: const Icon(Icons.event),
                    title: const Text("Event"),
                    subtitle: const Text("Click to add or remove Event"),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => NewsAdminScreen()));
                    },
                    trailing: const Icon(
                      Icons.ads_click_outlined,
                      color: Colors.redAccent,
                    ),
                    leading: const Icon(Icons.newspaper),
                    title: const Text("News"),
                    subtitle: const Text("Click to add or remove News"),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CategoryAdminScreen()));
                    },
                    trailing: const Icon(
                      Icons.ads_click_outlined,
                      color: Colors.redAccent,
                    ),
                    leading: const Icon(
                      Icons.category,
                    ),
                    title: const Text("Category"),
                    subtitle: const Text("Click to add or remove Sub category"),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SubCategoryAdminScreen()));
                    },
                    trailing: const Icon(
                      Icons.ads_click_outlined,
                      color: Colors.redAccent,
                    ),
                    leading: const Icon(Icons.inbox),
                    title: const Text("Sub Category"),
                    subtitle: const Text("Click to add or remove Category"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const ExpansionTile(
                  shape: Border(), // This removes the default border

                  leading: Icon(
                    Icons.receipt_long_outlined,
                    color: redLevelColor,
                  ),
                  title: Text(
                    "Overview",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
              const Spacer(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    CacheHelper.removeData(key: 'token');
                    CacheHelper.removeData(key: 'name');
                    CacheHelper.removeData(key: 'role');

                    CacheHelper.removeData(key: 'email');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                      Text(
                        "   Logout",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
