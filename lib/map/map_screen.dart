import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _showEnableLocationButton = false;

  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357), // Default location in Cairo
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndLocation();
  }

  Future<void> _checkPermissionsAndLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _showEnableLocationButton = true);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _showEnableLocationButton = true);
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _showEnableLocationButton = true);
      return;
    }

    await _getCurrentLocation();
    setState(() => _showEnableLocationButton = false);
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() => _currentPosition = LatLng(position.latitude, position.longitude));
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition!, 14));
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _mapController = controller,
            markers: _currentPosition != null
                ? {
              Marker(
                markerId: MarkerId("myLocation"),
                position: _currentPosition!,
                infoWindow: InfoWindow(title: "My Location"),
              ),
            }
                : {},
            myLocationEnabled: _currentPosition != null,
          ),
          if (_showEnableLocationButton)
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: () async {
                  bool opened = await openAppSettings();
                  if (opened) {
                    setState(() => _showEnableLocationButton = false);
                    _checkPermissionsAndLocation();
                  }
                },
                child: Text('Enable Location'),
              ),
            ),
        ],
      ),
    );
  }
}

