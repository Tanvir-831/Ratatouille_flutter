import 'package:flutter/material.dart';
import 'my_drawer.dart';

class MealNotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Note'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(), // Add the drawer here
      body: Center(
        child: Text(
          'This is the Meal Note page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
