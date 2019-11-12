import 'package:flutter/material.dart';
import 'package:real_time_ecg/view/landingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Time ECG',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'HelveticaNeue'),
      routes: {
        '/': (context) => new LandingScreen(),
      },
    );
  }
}
