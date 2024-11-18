import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/home_screen.dart';
import 'view/splash_screen/splash_screen.dart';
import 'view/widget/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorRes.backgroundColor,
      ),
      home: const SplashScreen(),
    );
  }
}