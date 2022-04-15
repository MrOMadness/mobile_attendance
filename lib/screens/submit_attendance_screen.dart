import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_attendance/templates/appbar_default.dart';
import 'package:mobile_attendance/templates/button_template.dart';

import '../styles.dart';

class SubmitAttendanceScreen extends StatelessWidget {
  final Map<String, dynamic> streamData;

  SubmitAttendanceScreen(this.streamData, {Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  // Collection reference from firebase
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDefault(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Submit Attendance',
                style: Styles.black_30_bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: ButtonTemplate('Submit', () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    double distanceInMeters =
                        await checkPositionDistance(streamData);
                    if (distanceInMeters < 50) {
                      await saveAttendance(
                          DateTime.now(), distanceInMeters, context, () {
                        Fluttertoast.showToast(
                          msg: "Attendance submited successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.of(context).pop();
                      });
                    } else {
                      await saveAttendance(
                          DateTime.now(), distanceInMeters, context, () {
                        Fluttertoast.showToast(
                          msg: "Range to HQ is > 50m. Move Closer!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                        );
                      });
                    }
                  }
                }))
          ],
        ),
      ),
    );
  }

  checkValid(distanceInMeters) {
    if (distanceInMeters < 50) {
      return true;
    } else {
      return false;
    }
  }

  checkLastValidAttendance(distanceInMeters, dateTime) {
    if (checkValid(distanceInMeters) == true) {
      // Valid Attendance
      return dateTime;
    } else {
      // Not Valid
      return DateTime.fromMicrosecondsSinceEpoch(0); //TODO: ganti?
    }
  }

  Future<double> checkPositionDistance(Map<String, dynamic> streamData) async {
    Position userPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    //startLatitude, startLongitude, endLatitude, endLongitude
    double distanceInMeters = Geolocator.distanceBetween(streamData['latitude'],
        streamData['longitude'], userPosition.latitude, userPosition.longitude);

    return distanceInMeters;
  }

  Future saveAttendance(DateTime dateTime, double distanceInMeters, context,
      Function successFunction) async {
// Check if document exist
    FirebaseFirestore.instance
        .collection('users')
        .doc(usernameController.text)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (!documentSnapshot.exists) {
        //if document doesn't exist, create new
        await users
            .doc(usernameController.text)
            .set({
              'user_name': usernameController.text,
              'last_valid_attendance':
                  checkLastValidAttendance(distanceInMeters, dateTime),
            }, SetOptions(merge: true))
            .then((value) => print("User Saved"))
            .catchError((error) => print("Failed to save user: $error"));
      } else {
        //if document exists, update the document
        if (checkValid(distanceInMeters)) {
          // if valid
          await users
              .doc(usernameController.text)
              .set({
                'user_name': usernameController.text,
                'last_valid_attendance':
                    checkLastValidAttendance(distanceInMeters, dateTime),
              }, SetOptions(merge: true))
              .then((value) => print("User Saved"))
              .catchError((error) => print("Failed to save user: $error"));
        } else {
          // not valid
          await users
              .doc(usernameController.text)
              .set({
                'user_name': usernameController.text,
              }, SetOptions(merge: true))
              .then((value) => print("User Saved"))
              .catchError((error) => print("Failed to save user: $error"));
        }
      }
    });

    // For attendance document field
    await users
        .doc(usernameController.text)
        .collection('attendances')
        .doc(dateTime.toString())
        .set({
      'date_time': dateTime,
      'is_valid': checkValid(distanceInMeters),
      'distance_in_meters': distanceInMeters
    }).then((value) {
      // On success
      successFunction();
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => Fluttertoast.showToast(
              // Add Failure toast
              msg: "Failed to submit attendance: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            ));
  }
}
