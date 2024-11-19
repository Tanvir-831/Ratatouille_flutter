import 'package:flutter/material.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'AI!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}