import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class KabaleLiveLocationMap extends StatefulWidget {
  const KabaleLiveLocationMap({super.key});

  @override
  State<KabaleLiveLocationMap> createState() => _KabaleLiveLocationMapState();
}

class _KabaleLiveLocationMapState extends State<KabaleLiveLocationMap> {
  late GoogleMapController mapController;

  final LatLng kabaleCenter = const LatLng(-1.2481, 29.9894); // Kabale Town

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kabale Waste Map"),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: kabaleCenter,
          zoom: 14,
        ),
      ),
    );
  }
}
