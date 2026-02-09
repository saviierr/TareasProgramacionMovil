import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? currentPosition;
  final Set<Marker> markers = {};
  final Set<Polyline> polylines = {};
  final List<LatLng> route = [];

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentPosition = LatLng(position.latitude, position.longitude);

    markers.add(
      Marker(
        markerId: const MarkerId("actual"),
        position: currentPosition!,
        infoWindow: const InfoWindow(title: "Mi ubicación"),
      ),
    );

    route.add(currentPosition!);

    polylines.add(
      Polyline(
        polylineId: const PolylineId("ruta"),
        color: Colors.blue,
        width: 5,
        points: route,
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa y Geolocalización")),
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentPosition!,
                zoom: 16,
              ),
              markers: markers,
              polylines: polylines,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
    );
  }
}
