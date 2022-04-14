import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_attendance/screens/change_location_screen.dart';
import 'package:mobile_attendance/templates/rounded_box_template.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Stream<DocumentSnapshot> _constantsStream =
      FirebaseFirestore.instance.collection('constants').doc('HQ').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _constantsStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            body: ListView(
                padding: const EdgeInsets.fromLTRB(12, 48, 12, 12),
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeHQLocationScreen(
                                  data['latitude'], data['longitude'])),
                        );
                      },
                      child: const RoundedBoxTemplate('Current Location', ''))
                ]),
          );
        });
  }
}
