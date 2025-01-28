import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';

class PickParkingSpotsController extends GenericController{
  final List<bool> parkingSpots = List.generate(30, (index) => false).obs;

  void toggleSpot(int index) {
    parkingSpots[index] = !parkingSpots[index];
  }
}