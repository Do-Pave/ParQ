import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:parq/app_config/custom_app_bar.dart';
import 'package:parq/app_config/mains.dart';
import 'package:parq/models/create_booking_model.dart';
import 'package:parq/nav%20bar/navigation_screen.dart';
import 'package:parq/parking/controller/eticket_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:parq/app_config/app_colors.dart';

import '../../app_config/date_utils.dart';
import '../../models/create_booking_model.dart';

class EticketScreen extends GetView<EticketController> {
  Data? eTicketData;
  EticketScreen({super.key, this.eTicketData});

  @override
  Widget build(BuildContext context) {
    final GlobalKey repaintBoundaryKey = GlobalKey();

    // Loading state variable
    RxBool isLoading = false.obs;

    Future<void> _captureAndSaveScreenshot() async {
      try {
        isLoading.value = true;  // Start loading
        await Future.delayed(Duration(milliseconds: 50)); // Brief delay
        await WidgetsBinding.instance.endOfFrame;

        RenderRepaintBoundary boundary =
        repaintBoundaryKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(
            pixelRatio: MediaQuery.of(context).devicePixelRatio);
        ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        final result = await ImageGallerySaver.saveImage(
          pngBytes,
          quality: 100,
          name: "E-Ticket_${DateTime.now().millisecondsSinceEpoch}",
        );

        if (result['isSuccess']) {
          Get.snackbar("Success", "Screenshot saved to gallery.");
        } else {
          Get.snackbar("Error", "Failed to save screenshot.");
        }
      } catch (e) {
        Get.snackbar("Error", "An error occurred: $e");
      } finally {
        isLoading.value = false;  // Stop loading
      }
    }

    return Scaffold(
      appBar: ParqAppBar(
        title: "E-Ticket",
        onBackTap: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: RepaintBoundary(
          key: repaintBoundaryKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                Center(
                    child: MainText(
                      textAlign: TextAlign.center,
                      isOverflow: false,
                      text:
                      "Scan this in the Scanner Machine \n When you're in the parking lot",
                      size: 18,
                      weight: FontWeight.w400,
                      color: AppColors.textGrey,
                    )),
                const SizedBox(height: 25),
                SizedBox(
                  width: Get.size.width / 1.8,
                  height: 180,
                  child: Center(
                    child: QrImageView(
                      data: eTicketData?.qrCode ?? "",
                      version: QrVersions.auto,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 4.0,
                  dashColor: AppColors.textGrey,
                  dashRadius: 0.0,
                  dashGapLength: 4.0,
                  dashGapColor: Colors.transparent,
                  dashGapRadius: 0.0,
                ),
                const SizedBox(height: 25),
                eticketRow("Name", eTicketData?.booking?.userInfo?.fullName ?? ""),
                const SizedBox(height: 15),
                eticketRow("Parking Area", eTicketData?.parking?.location?.address ?? ""),
                const SizedBox(height: 15),
                eticketRow("Arrival Time ", DateUtil.convertDate(eTicketData?.booking?.arrivingTime ?? "")),
                const SizedBox(height: 15),
                eticketRow("Exit Time", DateUtil.convertDate(eTicketData?.booking?.exitTime ?? "")),
                const SizedBox(height: 15),
                eticketRow("Spot", eTicketData?.booking?.parkingSpot ?? ""),
                const SizedBox(height: 15),
                eticketRow("Duration", "${eTicketData?.booking?.totalHours.toString() ?? ""} ${eTicketData?.booking?.totalHours?.isGreaterThan(1) == true  ? "Hours" : "Hour" }"),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 120,
          child: Obx(()=> Column(
              children: [
                isLoading.value ? const CircularProgressIndicator()
                    :
                MainButton(
                  color: AppColors.mainColor,
                  buttonText: "Download E-Ticket",
                  onTap: isLoading.value
                      ? null // Disable the button while loading
                      : _captureAndSaveScreenshot,
                ),
                const SizedBox(height: 10),
                MainButton(
                  color: AppColors.grey1,
                  buttonText: "Back to Home",
                  onTap: () {
                    Get.offAll(() => const NavScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget eticketRow(text, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          text: text,
          size: 18,
          weight: FontWeight.w400,
          color: AppColors.textGrey,
        ),
        MainText(
            text: value,
            size: 16,
            weight: FontWeight.w400,
            color: AppColors.black)
      ],
    );
  }
}
