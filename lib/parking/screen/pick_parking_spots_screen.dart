import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/pick_parking_spots_controller.dart';

class PickParkingSpotsScreen extends GetView<PickParkingSpotsController> {
  const PickParkingSpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PickParkingSpotsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick parking spots"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
              () => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 4, // Adjusts height of each slot
            ),
            itemCount: controller.parkingSpots.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => controller.toggleSpot(index),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Bottom separator line
                        width: 1,
                      ),
                      right: BorderSide(
                        color: Colors.grey, // Right separator line
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: controller.parkingSpots[index]
                        ? SvgPicture.asset("assets/images/carVector.svg",width: 100,)
                        : Text(
                      'Spot ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}