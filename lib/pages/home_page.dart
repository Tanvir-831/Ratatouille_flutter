import 'package:flutter/material.dart';
import 'package:recipe/pages/ai_screen.dart';
import 'package:recipe/pages/app_recipe_screen.dart';
import 'package:recipe/pages/favourite_screen.dart';
import 'package:recipe/pages/my_recipes_page.dart';
import 'my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  int selectedIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      const MyAppHomeScreen(),
      const FavoriteScreen(),
      const AiScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue[300],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Icons.smart_toy : Icons.smart_toy_outlined,
            ),
            label: "AI",
          ),
        ],
      ),
      body:  page[selectedIndex],
    );
  }
  Widget navBarPage(IconData iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: Colors.blue[900],
      ),
    );
  }
}

