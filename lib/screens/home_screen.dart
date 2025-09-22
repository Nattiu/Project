import 'package:flutter/material.dart';
// import 'package:galleria_app/constant/app.constant.dart';
import 'package:galleria_app/screens/onboard_screen.dart';
// import 'package:galleria_app/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Story data for the top row
  final List<Map<String, String>> storyItems = [
    {
      'image': 'assets/images/Lewis.jpg',
      'user': 'Lewis F1',
    },
    {
      'image': 'assets/images/Lando.jpg',
      'user': 'Lando',
    },
    {
      'image': 'assets/images/Leclerc.jpg',
      'user': 'Leclerc',
    },
  ];
  int _selectedIndex = 0;

  // Instagram-like post feed
  final List<Map<String, String>> postItems = [
    {
      'image': 'assets/images/Mc1-2.jpg',
      'user': 'Mclaren F1',
      'desc': 'Double Podium! 🏆',
      'likes': '10547',
    },
    {
      'image': 'assets/images/P1.jpg',
      'user': 'Formula 1',
      'desc': 'First Win! P1!!!!!',
      'likes': '9800',
    },
    {
      'image': 'assets/images/Podium.jpg',
      'user': 'Formula 1',
      'desc': 'Champagne on Podium',
      'likes': '8700',
    },
    {
      'image': 'assets/images/Mcl39.jpg',
      'user': 'Formula 1',
      'desc': 'MCL39 Fastest in grid 🏎',
      'likes': '9200',
    },
    // New posts for Lando, Lewis, Leclerc
    {
      'image': 'assets/images/Lando.jpg',
      'user': 'Lando Norris',
      'desc': 'It show time with McLaren',
      'likes': '6200',
    },
    {
      'image': 'assets/images/Lewis.jpg',
      'user': 'Lewis Hamilton',
      'desc': 'With Rocco', 
      'likes': '20320',
    },
    {
      'image': 'assets/images/Leclerc.jpg',
      'user': 'Leclerc',
      'desc': 'Red Suit & Red Car', 
      'likes': '4120',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Galleria',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat', // Use a modern, clean font
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ...story row removed...
                // Post Feed
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final post = postItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                              child: Image.asset(
                                post['image']!,
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person, color: Colors.grey[400], size: 22),
                                      const SizedBox(width: 8),
                                      Text(
                                        post['user']!,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    post['desc']!,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.favorite_border, color: Colors.red, size: 22),
                                      const SizedBox(width: 8),
                                      Text('${post['likes']} Likes', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.black : Colors.grey[400], size: 28),
              onPressed: () => setState(() => _selectedIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.search, color: _selectedIndex == 1 ? Colors.black : Colors.grey[400], size: 28),
              onPressed: () => setState(() => _selectedIndex = 1),
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: _selectedIndex == 2 ? Colors.black : Colors.grey[400], size: 28),
              onPressed: () => setState(() => _selectedIndex = 2),
            ),
            IconButton(
              icon: Icon(Icons.person, color: _selectedIndex == 3 ? Colors.black : Colors.grey[400], size: 28),
              onPressed: () {
                setState(() => _selectedIndex = 3);
                Navigator.pushNamed(context, '/profile').then((_) {
                  setState(() => _selectedIndex = 0);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Removed unused _buildNavItem method
}