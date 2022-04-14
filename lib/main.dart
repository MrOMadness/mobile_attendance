import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_attendance/nav_bar.dart';
import 'package:mobile_attendance/services/geolocator.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize firebase
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack); // Remove android status bar

  // Get current user location an check for errors
  var currentLocation = await AppGeolocator.determinePosition();
  if (kDebugMode) {
    print('Current location: $currentLocation');
  }

  runApp(const MyApp()); // Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Attendance', // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary theme color
      ),
      home: const NavBar(),
    );
  }
}
