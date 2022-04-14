import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_attendance/styles.dart';

class ChangeLocationScreen extends StatefulWidget {
  const ChangeLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLocationScreen> createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition savedLocation = CameraPosition(
    target:
        LatLng(-6.266568170668484, 106.64808394387364), //TODO: tarik val dri db
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Add back button
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: savedLocation,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        const Center(
          child: Positioned(
            child: Icon(
              Icons.person_pin_circle,
              size: 40,
              color: Colors.lightBlue,
            ),
          ),
        )
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton.extended(
          onPressed: () async {
            LatLng _currentCenter = await getCenter();
            print(_currentCenter);
            //TODO: Masukin val ke db
          },
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
