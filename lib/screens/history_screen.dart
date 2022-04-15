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
                return FutureBuilder(
                    future: checkAttendanceToday(document),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      return ListTile(
                        title: Text(document.id),
                        subtitle: Text("Today's attendance: ${snapshot.data}"),
                      );
                    });
              }).toList(),
            );
          }),
    );
  }

  Future<String> checkAttendanceToday(DocumentSnapshot document) async {
    Timestamp lastValidAttendance = await document.get('last_valid_attendance');

    if (calculateDifference(lastValidAttendance.toDate()) == 0) {
      return 'present';
    }
    return 'absent';
  }

  // https://stackoverflow.com/questions/54391477/check-if-datetime-variable-is-today-tomorrow-or-yesterday
  // Returns the difference (in full days) between the provided date and today.
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
