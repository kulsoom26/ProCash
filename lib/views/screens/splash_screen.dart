
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAndToNamed(kStartRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(kAppLogo),
        )),
      ),
    );
  }
}
