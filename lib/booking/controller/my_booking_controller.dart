import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyBookingController extends GetxController implements TickerProvider {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose(); // Dispose of the TabController when the controller is disposed
    super.onClose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
