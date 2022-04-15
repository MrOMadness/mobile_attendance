import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/styles.dart';

class ChangeHQLocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  ChangeHQLocationScreen(this.latitude, this.longitude, {Key? key})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();
  // Collection reference from firebase
  final CollectionReference constants =
      FirebaseFirestore.instance.collection('constants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Google Map
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 18, // set zoom level
          ),
          // To prevent exceeded sample count in FrameTime.
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        // Pin marker
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
        // Back Button
        Positioned(
          width: 50,
          height: 50,
          top: 25.0,
          left: 25.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.only(right: 0)),
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ]),
      // Save New Location
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton.extended(
          onPressed: () async {
            LatLng _currentCenter =
                await getCenter(); // Get lat and lng on pin marker

            // Update HQ document in firestore
            constants.doc('HQ').set({
              'latitude': _currentCenter.latitude,
              'longitude': _currentCenter.longitude,
              'last_update': DateTime.now()
            }).then((value) {
              // Add Successful toast
              Fluttertoast.showToast(
                msg: "Location saved successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
              Navigator.of(context).pop();
              // ignore: invalid_return_type_for_catch_error
            }).catchError((error) => Fluttertoast.showToast(
                  // Add Failure toast
                  msg: "Failed to save location: $error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                ));
          },
          // Label for floating action button
          label: const Text(
            'Save New Location',
            style: Styles.white_14,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // https://stackoverflow.com/questions/63212129/flutter-how-can-i-get-the-coordinates-of-the-center-of-the-map-in-google-maps
  Future<LatLng> getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    return centerLatLng;
  }
}
