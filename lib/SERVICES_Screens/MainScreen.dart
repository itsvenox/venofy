
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Pages/MainPages/CategoryPage.dart';
import '../Pages/MainPages/HomePage.dart';
import '../Pages/MainPages/ProfilePage.dart';
import '../Pages/MainPages/SearchPage.dart';
import '../constants.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final pages = [
    HomePage(),
    SearchPage(),
    // CategoryPage(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: xbg,
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        child: GNav(
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() => _currentIndex = index);
          },
          activeColor: xsc,
          padding: EdgeInsets.all(15),
          gap: 5,
          tabs: [
            GButton(icon: Icons.home_rounded, iconColor: xhtxt, text: "Home", textColor: xhtxt),
            GButton(icon: Icons.search_rounded, iconColor: xhtxt, text: "Search", textColor: xhtxt),
            // GButton(icon: Icons.category_rounded, iconColor: xhtxt, text: "Category", textColor: xhtxt),
            GButton(icon: Icons.person_outline_rounded, iconColor: xhtxt, text: "Profile", textColor: xhtxt),
          ],
        ),
      ),
    );
  }
}