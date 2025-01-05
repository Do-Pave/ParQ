import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/generic_controller.dart';
import 'package:parq/models/my_transactions_model.dart';
import 'package:parq/models/my_wallets_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/biometrics_login_service.dart';
import '../../core/Generics/refresh_token_class.dart';
import '../../core/constants.dart';
import '../../models/error_model.dart';

class HomeController extends GenericController {
  var currentIndex = 0.obs;
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  }

  // Update the current index
  void updateIndex(int index) {
    currentIndex.value = index;
  }

}
