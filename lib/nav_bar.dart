import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_attendance/screens/history_screen.dart';
import 'package:mobile_attendance/screens/home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Stream of DocumentSnapshot from firebase
    final Stream<DocumentSnapshot> _constantsStream = FirebaseFirestore.instance
        .collection('constants')
        .doc('HQ')
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
        stream: _constantsStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // error screen
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          // loading screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          Map<String, dynamic> streamData =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            body: Center(
              child: [
                HomeScreen(streamData),
                const HistoryScreen(),
              ].elementAt(_selectedIndex),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await checkPositionValidity();
                print('done');
              },
              child: const Icon(
                Icons.qr_code_scanner_outlined,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              // Library from AnimatedBottomNavigationBar
              icons: iconList,
              activeIndex: _selectedIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 20,
              rightCornerRadius: 20,
              onTap: (index) => setState(() => _selectedIndex = index),
            ),
          );
        });
  }
}

const iconList = [Icons.home, Icons.account_circle]; // Icons for bottom nav bar

Future<void> checkPositionValidity() async {
  Position userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);

  print('');
}
