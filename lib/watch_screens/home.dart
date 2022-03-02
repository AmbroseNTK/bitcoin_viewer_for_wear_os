import 'package:flutter/material.dart';
import 'package:watch_demo01/watch_screens/active.dart';
import 'package:watch_demo01/watch_screens/ambient.dart';
import 'package:wear/wear.dart';

class HomeWatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WatchShape(builder: ((context, shape, child) {
      return AmbientMode(builder: ((context, mode, ch) {
        return mode == WearMode.active ? ActiveScreen() : ActiveScreen();
      }));
    }));
  }
}
