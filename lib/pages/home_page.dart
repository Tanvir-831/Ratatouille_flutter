import 'package:flutter/material.dart';
import 'my_drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          'Welcome to Ratatouille!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
