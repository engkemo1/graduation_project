import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/screens/admin/events/widgets/add_event_screen.dart';
import 'package:graduation_project/view/screens/admin/events/widgets/events_data_screen.dart';

class EventsScreen extends StatelessWidget {
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
          title: const Text('Admin Events '),
          bottom: const TabBar(
            indicatorColor: redLevelColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.event,
                  color: redLevelColor,
                ),
                text: "Events",
              ),
              Tab(
                  icon: Icon(
                    Icons.add_circle_outline_sharp,
                    color: redLevelColor,
                  ),
                  text: "Add Events"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventsDataScreen(), // Replace with your content widget for tab 1
            AddEventScreen()
          ],
        ),
      ),
    );
  }
}
