import 'package:flutter/material.dart';
import 'package:mobile_attendance/templates/appbar_default.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLocationScreen> createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarDefault(),
      body: Text('Change Location Screen'),
    );
  }
}
