import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Stream of DocumentSnapshot from firebase
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // error screen
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            // loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading"); //TODO: Bikin loading screen
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                // Map<String, dynamic> data =
                //     document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(document.id),
                  subtitle:
                      Text("Today's attendance: ${checkLoginToday(document)}"),
                );
              }).toList(),
            );
          }),
    );
  }

  String checkLoginToday(document) {
    print(document);
    return 'present';
  }
}
