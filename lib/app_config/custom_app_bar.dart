import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  final bool withBack;
  Function()? notifiactionOnTap;
  Function()? profileTapped;
  void Function()? onPressed;
  CustomAppBar(
      {super.key,
      this.onPressed,
      required this.title,
      this.withBack = false,
      this.notifiactionOnTap,
      this.profileTapped});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      leading: withBack
          ? IconButton(
              onPressed: onPressed ??
                  () {
                    Get.back();
                  },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )
          : IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppColors.blueWhite,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //     onTap: () {
              //       // Get.to(const NotificationScreen());
              //     },
              //     child: const Icon(
              //       Icons.menu,
              //       color: AppColors.blueWhite,
              //     )),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  InkWell(
                      onTap: notifiactionOnTap,
                      child:
                          SvgPicture.asset("assets/images/Notification.svg")),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: profileTapped,
                      child: ClipOval(
                        child: Image.network(
                          "https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Text(
          //   "Hey trainer".tr,
          //   style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300,color: Colors.white),
          // )
        ],
      ),
    );
  }
}

class ParqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  String? title;
  bool? hasBack = true;
  ParqAppBar({super.key, this.hasBack, this.onBackTap, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title ?? "",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
        leading: InkWell(
          onTap: onBackTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: hasBack == false
                ? null
                : Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey.shade300),
                      color: AppColors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
          ),
        ));
  }
}

class KhardaAppBarGradient extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackTap;
  final String? title;
  final bool hasBack;

  KhardaAppBarGradient({
    Key? key,
    this.onBackTap,
    this.title,
    this.hasBack = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(180);

  final form = FormGroup({
    'search': FormControl<String>(validators: []),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Background
        Container(
          height: preferredSize.height,
          decoration: const BoxDecoration(
            gradient: AppColors.homeScrGradientColor,

          ),
        ),
        // AppBar Content
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                title ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
              centerTitle: true,
                leading: InkWell(
                  onTap: onBackTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: hasBack == false
                        ? null
                        : Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 15,
                        color: AppColors.blueWhite,
                      ),
                    ),
                  ),
                )
            ),
SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.blueWhite,
                ),
                child: ReactiveForm(
                  formGroup: form,
                  child:ReactiveTextField(
                    formControlName: "search",
                        decoration: InputDecoration(
                        hintText: "Search for Bank Name".tr,
                        hintStyle: TextStyle(color: Colors.grey.shade400,fontSize: 16,fontWeight: FontWeight.w400),
                        prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,),
                        border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 15), // Adjust vertical padding
                        ),
                        style: const TextStyle(fontSize: 16),
                        ),
                  ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";
  String? tralingText = "";
  Icon? tralingIcon;
  final VoidCallback? onBackTap;
  void Function()? trailingOnTap;
  void Function()? trailingOnTapText;
  Color? backColor;

  DefaultAppBar(
      {super.key,
      required this.title,
      required this.onBackTap,
      this.tralingText,
      this.tralingIcon,
      this.trailingOnTap,
      this.trailingOnTapText,
      this.backColor});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
      leading: InkWell(
        onTap: onBackTap,
        child: Icon(
          Icons.arrow_back,
          color: backColor ?? Colors.black,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              InkWell(
                onTap: trailingOnTapText,
                child: Text(
                  tralingText ?? "",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffDA1414)),
                ),
              ),
              InkWell(
                onTap: trailingOnTap,
                child: tralingIcon ??
                    const Icon(
                      Icons.more_vert,
                      color: Colors.transparent,
                    ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class AppBarWithTabBar extends StatelessWidget implements PreferredSizeWidget {
  String title = "";
  final VoidCallback? onBackTap;

  AppBarWithTabBar({super.key, required this.title, required this.onBackTap});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.flight)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            Center(child: Icon(Icons.flight, color: Colors.red, size: 350)),
            Icon(Icons.bike_scooter, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
