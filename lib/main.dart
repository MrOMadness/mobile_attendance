import 'package:flutter/material.dart';
import 'package:mobile_attendance/nav_bar.dart';
import 'package:mobile_attendance/services/geolocator.dart';

void main() async {
  runApp(const MyApp());
  var currentLocation = await AppGeolocator.determinePosition();
  print('Current location: $currentLocation');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavBar(),
    );
  }
}
