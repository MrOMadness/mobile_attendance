import 'package:flutter/material.dart';

class AppBarReturn extends StatelessWidget with PreferredSizeWidget {
  const AppBarReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey.shade50,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
