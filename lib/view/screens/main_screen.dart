import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/view/screens/categories/categories_screen.dart';
import 'package:graduation_project/view/screens/favourites/favourites_screen.dart';
import 'package:graduation_project/view/screens/home_screen/home_screen.dart';
import 'package:graduation_project/view/screens/news/news_screen.dart';
import 'package:graduation_project/view/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    NewsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/home.png"),
            activeIcon: Container(
              padding: EdgeInsets.all(7),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Image.asset("assets/icons/home.png"),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/reports.png"),
            activeIcon: Container(
              padding: EdgeInsets.all(7),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Image.asset("assets/icons/reports.png"),
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/Categorize.png"),
            activeIcon: Container(
              padding: EdgeInsets.all(7),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Image.asset("assets/icons/Categorize.png"),
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/fav.png"),
            activeIcon: Container(
              padding: EdgeInsets.all(7),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Image.asset("assets/icons/fav.png"),
            ),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/person.png"),
            activeIcon: Container(
              padding: EdgeInsets.all(7),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Image.asset("assets/icons/person.png"),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
