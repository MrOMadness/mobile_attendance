// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:mobile_attendance/templates/appbar_default.dart';
import 'package:mobile_attendance/templates/button_template.dart';

import '../styles.dart';

class SubmitAttendanceScreen extends StatelessWidget {
  double distanceInMeters;

  SubmitAttendanceScreen(this.distanceInMeters, {Key? key}) : super(key: key);

  TextEditingController newData = TextEditingController();

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
                'Change',
                style: Styles.black_30_bold,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Submit Attendance',
                style: Styles.black_30_bold,
              ),
            ),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
            //     child: Text(
            //       'Current $formTitle',
            //       style: Styles.black_15_bold,
            //     )),
            // Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.only(top: 10),
            //     child: BoxTemplate(Text(
            //       currentData,
            //       style: Styles.black_15,
            //     ))),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            //     child: Text(
            //       'New $formTitle',
            //       style: Styles.black_15_bold,
            //     )),
            // Container(
            //     alignment: Alignment.center,
            //     padding: const EdgeInsets.only(top: 10),
            //     child: BoxTemplate(
            //       TextField(
            //         controller: newData,
            //         decoration: InputDecoration(
            //           border: InputBorder.none,
            //           hintText: 'New $formTitle',
            //         ),
            //       ),
            //     )),
            Container(
                margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: ButtonTemplate('Confirm', () async {}))
          ],
        ),
      ),
    );
  }
}
