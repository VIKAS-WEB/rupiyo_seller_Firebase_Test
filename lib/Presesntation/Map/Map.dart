import 'package:flutter/material.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapmyIndiaMapController mapController;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map My India Examples'),
      ),
      body: MapmyIndiaMap(initialCameraPosition: CameraPosition(
        target: LatLng(28.6139, 77.2090),
        zoom: 12.0,
        )
        ),
    );
  }
}