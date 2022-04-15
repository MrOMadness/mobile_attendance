import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_attendance/styles.dart';
import 'package:mobile_attendance/templates/appbar_default.dart';
import 'package:intl/intl.dart';
import 'package:mobile_attendance/templates/loading_template.dart';

class HistoryDetailScreen extends StatefulWidget {
  final String userId;

  const HistoryDetailScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Stream of QuerySnapshot from firebase
    final Stream<QuerySnapshot> _attendancesStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('attendances')
        .snapshots();

    return Scaffold(
        appBar: const AppBarDefault(),
        body: StreamBuilder<QuerySnapshot>(
            stream: _attendancesStream,
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
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ListTile(
                    title: Text(
                        DateFormat.yMd().add_jm().format(document
                            .get('date_time')
                            .toDate()), // Format date for better view
                        style: Styles.black_16),
                    subtitle: Text(
                        "Distance from HQ: ${document.get('distance_in_meters').toStringAsFixed(2)}m", // Format to 2 decimal places
                        style: Styles.grey_13),
                  );
                }).toList(),
              );
            }));
  }
}
