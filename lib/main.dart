import 'package:flutter/material.dart';
import 'package:stop_watch/screens/homeScreen.dart';

void main() {
  runApp(StopWatch());
}

class StopWatch extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomeScreen(),
    );
  }
}

