import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parq/app_config/app_colors.dart';

class MainButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final Color? color;
  double? width;
  double? height;
  Gradient? gradient;

  MainButton(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.color,
      this.width,
      this.height,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? Get.size.width,
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        decoration: BoxDecoration(
          // Apply solid color if color is provided
          color: color ?? null,
          // Apply gradient only if color is null
          gradient: color == null
              ? gradient
              : null,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class imageWithTextButton extends StatelessWidget {
  String? image;
  String? title;
  Function()? onTap;
  imageWithTextButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: AppColors.homeScrGradientColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Image.asset(image ?? "",),
              const SizedBox(
                width: 10,
              ),
              Text(
                title?.tr ?? "",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
