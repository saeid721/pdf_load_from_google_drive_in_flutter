import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';
import 'splash_screen/custom_background_widget.dart';
import 'widget/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User's image or placeholder
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/placeholder.png'), // Replace with your asset
                      fit: BoxFit.cover,
                    ),
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
                    shape: const CircleBorder(), backgroundColor: ColorRes.primaryColor,
                    padding: const EdgeInsets.all(20), // Button color
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
      ),
    );
  }
}
