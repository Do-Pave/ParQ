import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parq/app_config/custom_app_bar.dart';

import '../app_config/app_colors.dart';
import '../app_config/mains.dart';

class SearchMapScreen extends StatefulWidget {
  @override
  _SearchMapScreenState createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  late GoogleMapController mapController;
  LatLng currentLocation = LatLng(0, 0); // Default location
  Set<Marker> markers = {};
  Set<Circle> circles = {}; // Set to hold circles

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);

      // Add the main pin
      markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation,
          infoWindow: InfoWindow(title: 'My Location'),
        ),
      );

      // Add a circle around the main pin
      circles.add(
        Circle(
          circleId: CircleId('current_location_circle'),
          center: currentLocation,
          radius: 200, // Radius in meters
          fillColor: Colors.blue.withOpacity(0.2), // Semi-transparent blue
          strokeColor: Colors.blue, // Border color
          strokeWidth: 2, // Border width
        ),
      );

      _addOtherLocations();
    });
  }

  void _addOtherLocations() {
    // Add 5 additional locations with different pins
    List<LatLng> otherLocations = [
      LatLng(currentLocation.latitude + 0.01, currentLocation.longitude),
      LatLng(currentLocation.latitude - 0.01, currentLocation.longitude),
      LatLng(currentLocation.latitude, currentLocation.longitude + 0.01),
      LatLng(currentLocation.latitude, currentLocation.longitude - 0.01),
      LatLng(
          currentLocation.latitude + 0.005, currentLocation.longitude + 0.005),
    ];

    for (int i = 0; i < otherLocations.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('location_$i'),
          position: otherLocations[i],
          infoWindow: InfoWindow(title: 'Location $i'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueCyan, // Different color for other locations
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation.latitude != 0
          ? Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 15,
            ),
            markers: markers,
            circles: circles, // Add circles to the map
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
            child: Positioned(
                top: 30,
                left: 30,
                child: Container(
                  width: Get.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.grey2, width: 1),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/searchIcon.svg', // Path to your SVG file
                          height: 20,
                          width: 20,
                          fit: BoxFit.scaleDown,
                          color: AppColors.mainColor, // Color of the SVG icon
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MainText(
                          text: "Search Parking",
                          color: AppColors.textGrey,
                          size: 14,
                          weight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9).withOpacity(0.50),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
