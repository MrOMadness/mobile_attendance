import 'package:flutter/material.dart';

// Template for app bar that only have back arrow
class AppBarDefault extends StatelessWidget with PreferredSizeWidget {
  const AppBarDefault({Key? key}) : super(key: key);

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
