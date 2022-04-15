import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_attendance/screens/history_detail_screen.dart';
import 'package:mobile_attendance/styles.dart';
import 'package:mobile_attendance/templates/loading_template.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Stream of QuerySnapshot from firebase
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // error screen
            if (snapshot.hasError) {
              return Center(
                  child: Text('Something went wrong: ${snapshot.error}'));
            }
            // loading screen
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingTemplate();
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return FutureBuilder(
                      future: checkAttendanceToday(
                          document), // Check if user present/absent
                      builder: (context, snapshot) {
                        return ListTile(
                            title: Text(document.id, style: Styles.black_16),
                            subtitle: Text(
                              "Today's attendance: ${snapshot.data}",
                              style: Styles.grey_13,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryDetailScreen(
                                        document.id)), // To detail screen
                              );
                            });
                      });
                }).toList(),
              ),
            );
          }),
    );
  }

  // Check if user present/absent
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
