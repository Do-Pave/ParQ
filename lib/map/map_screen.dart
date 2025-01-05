import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(0, 0), // Default location
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location services are disabled. Please enable them.')),
      );
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // Move the camera to the current location
    _mapController?.animateCamera(
      CameraUpdate.newLatLng(_currentPosition!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Container(

        height: 300, // Adjust container height
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              if (_currentPosition != null) {
                _mapController?.animateCamera(
                  CameraUpdate.newLatLng(_currentPosition!),
                );
              }
            },
            markers: _currentPosition != null
                ? {
              Marker(
                markerId: MarkerId("myLocation"),
                position: _currentPosition!,
                infoWindow: InfoWindow(title: "My Location"), // Custom title
                // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen), // Custom color (Azure)
              ),
            }
                : {},
            myLocationEnabled: true,
          ),
        ),
      ),
    );
  }
}
