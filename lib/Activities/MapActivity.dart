import 'package:flutter/material.dart';

class MapActivity extends StatefulWidget {
  const MapActivity({super.key});

  @override
  State<MapActivity> createState() => _MapActivityState();
}

class _MapActivityState extends State<MapActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Map Activity"),
      ),
    );
  }
}
