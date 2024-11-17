import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/my_recipes_page.dart';
import 'pages/meal_note_page.dart';
import 'pages/my_bmi_page.dart';
import 'pages/food_calory_chart_page.dart';
import 'pages/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ratatouille',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/my_recipes': (context) => MyRecipesPage(),
        '/meal_note': (context) => MealNotePage(),
        '/my_bmi': (context) => MyBmiPage(),
        '/food_calory_chart': (context) => FoodCaloryChartPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
