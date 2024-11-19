import 'package:flutter/material.dart';
//import 'package:flutter_complete_app/Views/view_all_items.dart';
//import 'package:flutter_complete_app/Widget/banner.dart';
//import 'package:flutter_complete_app/Widget/food_items_display.dart';
//import 'package:flutter_complete_app/Widget/my_icon_button.dart';

class MyAppHomeScreen extends StatefulWidget {
  const MyAppHomeScreen({super.key});

  @override
  _MyAppHomeScreenState createState() => _MyAppHomeScreenState();
}

class _MyAppHomeScreenState extends State {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
