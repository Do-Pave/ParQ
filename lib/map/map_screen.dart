import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with WidgetsBindingObserver {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _permissionDenied = false;
  bool _isSnackBarVisible = false; // Prevent multiple SnackBars
  bool _hasCheckedPermissions = false; // Ensure permissions are checked only once after resuming
  final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(0, 0), // Default location
    zoom: 14,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Observe app lifecycle changes
    _checkPermissionsAndLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_hasCheckedPermissions) {
      // Recheck permissions only once when resuming
      _hasCheckedPermissions = true;
      _checkPermissionsAndLocation();
    }
  }

  Future<void> _checkPermissionsAndLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Location services are disabled. Please enable them.');
      setState(() {
        _permissionDenied = true;
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Request permissions again
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        _showSnackBar('Location permissions are denied. Please enable them in settings.');
        setState(() {
          _permissionDenied = true;
        });
        return;
      }
    }

    // If permission is granted, get the current location
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      await _getCurrentLocation();
      setState(() {
        _permissionDenied = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      // Move the camera to the current location
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_currentPosition!),
      );
    } catch (e) {
      _showSnackBar('Error getting location: $e');
    }
  }

  void _showSnackBar(String message) {
    if (!_isSnackBarVisible) {
      _isSnackBarVisible = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ),
      ).closed.then((_) {
        _isSnackBarVisible = false;
      });
    }
  }

  Future<void> _openAppSettings() async {
    final isOpened = await openAppSettings();
    if (!isOpened) {
      _showSnackBar('Unable to open app settings.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _permissionDenied
          ? Center(
        child: ElevatedButton(
          onPressed: _openAppSettings,
          child: Text('Enable Location in Settings'),
        ),
      )
          : _currentPosition == null
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
