import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/screens/change_location_screen.dart';
import 'package:mobile_attendance/templates/rounded_box_template.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> streamData;
  const HomeScreen(this.streamData, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    CameraPosition hqPosition = CameraPosition(
      target:
          LatLng(widget.streamData['latitude'], widget.streamData['longitude']),
      zoom: 18, // set zoom level
    );

    Future<void> updateLocation() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(hqPosition));
    }

    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.fromLTRB(12, 48, 12, 12),
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeHQLocationScreen(
                            widget.streamData['latitude'],
                            widget.streamData['longitude'])),
                  );
                },
                child: const RoundedBoxTemplate('Change HQ Location', '')),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              height: 250,
              child: Stack(children: [
                FutureBuilder(
                    future: updateLocation(),
                    builder: (context, snapshot) {
                      return GoogleMap(
                        initialCameraPosition: hqPosition,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                        },
                      );
                    }),
                const Center(
                  child: Positioned(
                    child: Icon(
                      Icons.person_pin_circle,
                      size: 40,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ]),
            )
          ]),
    );
  }
}
