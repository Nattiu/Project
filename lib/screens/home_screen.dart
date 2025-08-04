import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:galleria_app/screens/profile_screen.dart';
import '../constant/app.constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { 

  int _pageIndex = 0;
  final _Pages = [
    Center(child: Text('Home Page', style: headingtextStyle,)),
    Center(child: Text('Search Page', style: headingtextStyle,)),
    Center(child: Text('Notifications Page', style: headingtextStyle,)),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,

      body: _Pages[_pageIndex],
      

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: primaryColor,

        items: [
          Icon(Icons.home, size: 30, color: secondaryColor),
          Icon(Icons.search, size: 30, color: secondaryColor),
          Icon(Icons.notifications, size: 30, color: secondaryColor),
          Icon(Icons.person, size: 30, color: secondaryColor),
        ],

        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        ),
    );
  }
}