import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class KabaleWasteMap extends StatefulWidget {
  @override
  State<KabaleWasteMap> createState() => _KabaleWasteMapState();
}

class _KabaleWasteMapState extends State<KabaleWasteMap> {
  GoogleMapController? mapController;

  final LatLng _kabaleTown = const LatLng(-1.2493, 29.9870);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kabale Waste Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _kabaleTown,
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
          });
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
