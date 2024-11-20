import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.restaurant_menu, // Recipe-themed icon
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Ratatouille',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('My Recipes'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/my_recipes');
            },
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Meal Note'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/meal_note');
            },
          ),
          ListTile(
            leading: Icon(Icons.monitor_weight),
            title: Text('My BMI'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/my_bmi');
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text('Food Calory Chart'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/food_calory_chart');
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.health_and_safety), // A more health-oriented icon
            title: Text('Calory Calculator'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/calory_calculator');
              // Add functionality for calory calculator
            },
          ),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
