import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsExplorer extends StatefulWidget {
  const MapsExplorer({Key? key}) : super(key: key);

  @override
  State<MapsExplorer> createState() => _MapsExplorerState();
}

class _MapsExplorerState extends State<MapsExplorer> {
  static final LatLng initialPosition = LatLng(25.281235, 89.112174);
    GoogleMapController? _mapController;
    
  void onMapCreated(GoogleMapController contro) {
    _mapController = contro;
  }

  final _initialCameraPosition = CameraPosition(
      target: initialPosition, zoom: 11.0, tilt: 0.0, bearing: 0.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: onMapCreated,
      ),
    );
  }
}
