import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class KabaleLiveLocationMap extends StatefulWidget {
  @override
  State<KabaleLiveLocationMap> createState() => _KabaleLiveLocationMapState();
}

class _KabaleLiveLocationMapState extends State<KabaleLiveLocationMap> {
  GoogleMapController? _mapController;
  StreamSubscription<Position>? _positionStream;
  LatLng? _currentPosition;

  // Default to Kabale Town center
  final LatLng _kabaleTown = LatLng(-1.2493, 29.9870);

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  /// Request permission + start tracking
  Future<void> _initializeLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // Live location updates
    _positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position pos) {
      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
      });

      // Automatically move camera
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentPosition!),
        );
      }
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location — Kabale")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _kabaleTown,
          zoom: 15,
        ),
        myLocationEnabled: false, // we draw our own marker
        myLocationButtonEnabled: true,
        onMapCreated: (controller) => _mapController = controller,
        markers: _currentPosition == null
            ? {}
            : {
                Marker(
                  markerId: MarkerId("user"),
                  position: _currentPosition!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                  infoWindow: InfoWindow(title: "You are here"),
                ),
              },
      ),
    );
  }
}
