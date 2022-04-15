import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_attendance/nav_bar.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize firebase

  // Location permission
  LocationPermission permission;
  permission = await Geolocator.requestPermission();

  // Remove android status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  runApp(const MyApp()); // Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Attendance', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.lightBlue, // Primary theme color
      ),
      home: const NavBar(),
    );
  }
}
