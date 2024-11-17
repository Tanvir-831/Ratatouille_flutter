import 'package:flutter/material.dart';
import 'my_drawer.dart';

class MyRecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(), // Add the drawer here
      body: Center(
        child: Text(
          'This is the My Recipes page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
