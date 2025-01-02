import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationManuallyController extends GenericController{
  final TextEditingController textController = TextEditingController();

  void requestPermissions() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      // Permissions granted, continue with geolocation operations
      fetchCurrentLocation();
    } else {
      // Handle the case where the user denies the permission
    }
  }
  // Get user's current location
  Future<void> fetchCurrentLocation() async {
    // Check if location services are enabled
    await Future.delayed(Duration(seconds: 1)); // Ensure that the app is fully initialized
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle if location services are disabled
      debugPrint("Location services are disabled.");
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Handle permission denial
      debugPrint("Location permission denied.");
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    // You can update your controller state or UI with the coordinates here
  }
}