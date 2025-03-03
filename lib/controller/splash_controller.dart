import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/home_screen.dart';

class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  AnimationController get getAnimationController => _controller;

  @override
  void onInit() {
    super.onInit();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.easeIn)),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack)),
    );

    slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic)),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      Get.off(() => const HomeScreen(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 800));
    });
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }

  void navigateToHome() {
    Get.to(() => const HomeScreen(), transition: Transition.rightToLeft);
  }
}