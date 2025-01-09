import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';

class HelpCenterController extends GenericController implements TickerProvider {
  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxInt expandedIndex = (-1).obs;

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