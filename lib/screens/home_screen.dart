import 'package:flutter/material.dart';
import 'package:mobile_attendance/screens/change_location_screen.dart';
import 'package:mobile_attendance/templates/rounded_box_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 12),
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangeHQLocationScreen()),
                  );
                },
                child: RoundedBoxTemplate('Current Location', ''))
          ]),
    );
  }
}
