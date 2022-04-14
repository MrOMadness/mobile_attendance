// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Style page
class Styles {
  static const String poppinsFont = 'poppins';
  static const int lightBlue = 0xffD8E3E7;
  static const int grey = 0xff665555;

  static const TextStyle black_16 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 16,
  );

  static const TextStyle grey_13 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 13,
    color: Color(grey),
  );

  static const TextStyle white_14 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 14,
    color: Colors.white,
  );
}
