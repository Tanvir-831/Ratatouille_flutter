import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:recipe/services/favorite_provider.dart';
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/my_recipes_page.dart';
import 'pages/meal_note_page.dart';
import 'pages/my_bmi_page.dart';
import 'pages/food_calory_chart_page.dart';
import 'pages/profile_page.dart';
import 'pages/calory_calculator.dart';
import 'services/quantity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ChangeNotifierProvider(create: (_) => QuantityProvider())
    ],
    child: MyApp(),
  ),);
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
        '/my_recipes': (context) => MyRecipesPage(),
        '/meal_note': (context) => MealNotePage(),
        '/my_bmi': (context) => MyBmiPage(),
        '/food_calory_chart': (context) => FoodCaloryChartPage(),
        '/profile': (context) => ProfilePage(),
        '/calory_calculator': (context) => CaloryCalculator(),
      },
    );
  }
}
