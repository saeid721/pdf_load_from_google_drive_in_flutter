import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/constants/colors_resources.dart';
import '../home_screen.dart';
import 'custom_background_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    return Scaffold(
      body: CustomBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width,
                height: 400,
                child: const Image(
                  image: AssetImage('assets/images/book_lovers.png'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              // Main text
              const Text(
                "Reading Is Fascinating",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorRes.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              // Subtitle text
              const Text(
                "World of endless knowledge awaits you!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorRes.textColor,
                ),
              ),
              const SizedBox(height: 40),
              // Start button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const HomeScreen());
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: ColorRes.primaryColor,
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
