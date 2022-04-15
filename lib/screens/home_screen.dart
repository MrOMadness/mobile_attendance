import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/screens/change_location_screen.dart';
import 'package:mobile_attendance/styles.dart';
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
    // G-map position for HQ
    CameraPosition hqPosition = CameraPosition(
      target:
          LatLng(widget.streamData['latitude'], widget.streamData['longitude']),
      zoom: 18, // set zoom level
    );

    // Function to update g-map location
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
                            widget.streamData[
                                'longitude'])), // To Change HQ Location Screen
                  );
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: const RoundedBoxTemplate('Change HQ Location', ''))),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Stack(children: [
                FutureBuilder(
                    future: updateLocation(), // Update g-map location
                    builder: (context, snapshot) {
                      return GoogleMap(
                        // Make static g-map, only can zoom
                        compassEnabled: false,
                        mapToolbarEnabled: false,
                        rotateGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: hqPosition,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                        },
                      );
                    }),
                // Pin Marker
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: Icon(
                      Icons.person_pin_circle,
                      size: 40,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: RichText(
                text: const TextSpan(
                  text:
                      'Please make sure your phone is connected to the internet!\n\nFor documentation, please refer to ',
                  style: Styles.black_15,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'https://github.com/MrOMadness/mobile_attendance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
