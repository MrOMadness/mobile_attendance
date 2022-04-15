// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// Style page
class Styles {
  static const String poppinsFont = 'poppins';
  static const int darkBlue = 0xff062076;
  static const int lightBlue = 0xffD8E3E7;
  static const int grey = 0xff665555;

  static const TextStyle black_30_bold = TextStyle(
    fontFamily: poppinsFont,
    fontWeight: FontWeight.bold,
    fontSize: 30,
  );

  static const TextStyle black_15_bold = TextStyle(
    color: Colors.black,
    fontFamily: poppinsFont,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle black_16 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 16,
  );

  static const TextStyle black_15 = TextStyle(
    color: Colors.black,
    fontFamily: poppinsFont,
    fontSize: 15,
  );

  static const TextStyle grey_13 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 13,
    color: Color(grey),
  );

  static const TextStyle white_15_bold = TextStyle(
      fontFamily: poppinsFont,
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.white);

  static const TextStyle white_14 = TextStyle(
    fontFamily: poppinsFont,
    fontSize: 14,
    color: Colors.white,
  );
}
