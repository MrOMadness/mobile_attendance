import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_attendance/nav_bar.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize firebase
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack); // Remove android status bar

  // Get current user location an check for errors
  // var currentLocation = await AppGeolocator.determinePosition();

  // print('Current location: $currentLocation');
  //TODO: Tambahin sesuatu klo blm konek ke inet

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
