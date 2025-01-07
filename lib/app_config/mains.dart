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
          gradient: color == null ? gradient : null,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            buttonText.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
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
              Image.asset(
                image ?? "",
              ),
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

class MainText extends StatelessWidget {
  final String text;
  final Color? color;
  double? size;
  FontWeight? weight;
  bool? underlined = false;
  bool? isOverflow = true;
  bool? hasMaxLines = true;
  TextAlign? textAlign;


  MainText(
      {super.key,
      required this.text,
      this.color,
      this.size,
      this.weight,
      this.isOverflow,
      this.hasMaxLines,
      this.textAlign,
      this.underlined});

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: isOverflow == true ? TextOverflow.ellipsis : null,
      maxLines: hasMaxLines == true ? 1 : 4,
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: color,
          decoration: underlined == true ? TextDecoration.underline : null,
          decorationColor: AppColors.green),
    );
  }
}
