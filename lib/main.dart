import 'package:flutter/material.dart';
import 'package:watch_demo01/watch_screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Watch Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeWatchScreen());
  }
}
