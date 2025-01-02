// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:parq/app_config/biometric_auth.dart';
// import 'package:parq/app_config/mains.dart';
// import 'package:parq/auth/screens/login_with_number_screen.dart';
// import 'package:parq/auth/screens/sign_up_screen.dart';
// import 'package:parq/nav%20bar/navigation_screen.dart';
//
// import '../app_config/app_colors.dart';
//
// class Onboarding extends StatefulWidget {
//   const Onboarding({super.key});
//
//   @override
//   State<Onboarding> createState() => _OnboardingState();
// }
//
// class _OnboardingState extends State<Onboarding> {
//   Future<void> _handleBiometricLogin() async {
//     final biometricAuth = BiometricAuth();
//     final bool canCheckBiometrics = await biometricAuth.canCheckBiometrics();
//
//     if (canCheckBiometrics) {
//       final bool isAuthenticated = await biometricAuth.authenticate();
//
//       if (isAuthenticated) {
//         Get.to(() => const NavScreen());
//       } else {
//         debugPrint("Authentication failed");
//         _showAuthenticationFailedDialog();
//       }
//     } else {
//       debugPrint("Biometrics are not available");
//       _showBiometricUnavailableDialog();
//     }
//   }
//
//   void _showAuthenticationFailedDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Authentication Failed'),
//           content:
//               const Text('Biometric authentication failed. Please try again.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _showBiometricUnavailableDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Biometrics Unavailable'),
//           content: const Text(
//               'Biometric authentication is not available on this device.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _showBiometricUnavailableDialog() {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Biometrics Unavailable'),
//             content: const Text(
//                 'Biometric authentication is not available on this device.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     return Scaffold(
//       // appBar: AppBar(),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   "assets/images/splashImage.svg",
//                   width: 150,
//                 ),
//                 const SizedBox(height: 30),
//                 Image.asset(
//                   "assets/images/onboarding.png",
//                   // width: MediaQuery.of(context).size.width / 1.5,
//                   height: Get.size.height / 4,
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   "The fastest transaction\n process only here",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColors.grey),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 30),
//                 MainButton(
//                   gradient: AppColors.homeScrGradientColor,
//                   onTap: () {
//                     debugPrint("Sign up tapped");
//                     Get.to(() => const SignupScreen());
//                   },
//                   buttonText: 'Sign up',
//                 ),
//                 const SizedBox(height: 15),
//                 SizedBox(
//                   // color: Colors.amber,
//                   width: Get.size.width,
//                   height: 20,
//                   child: GestureDetector(
//                       onTap: () {
//                         debugPrint("Log in tapped");
//                         Get.to(() => const LoginWithNumberScreen());
//                         // _handleBiometricLogin();
//                       },
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xff3366CC)),
//                         textAlign: TextAlign.center,
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
