import 'package:flutter/material.dart';

class AmbientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AmbientScreenState();
  }
}

class AmbientScreenState extends State<AmbientScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Ambient'),
    );
  }
}
