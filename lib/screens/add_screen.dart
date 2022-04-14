import 'package:flutter/material.dart';
import 'package:mobile_attendance/templates/appbar_default.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarDefault(),
      body: Center(child: Text('Add Screen')),
    );
  }
}
