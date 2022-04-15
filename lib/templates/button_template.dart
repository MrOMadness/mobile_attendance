// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../styles.dart';

class ButtonTemplate extends StatelessWidget {
  String text;
  Function function;

  ButtonTemplate(this.text, this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              primary: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            text,
            style: Styles.white_15_bold,
          ),
          onPressed: () async {
            await function();
          },
        ));
  }
}
