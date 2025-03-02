import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../controller/splash_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_button.dart';
import '../../global/widget/global_sizedbox.dart';
import '../../global/widget/global_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = "1.0.1"; // Default version

  @override
  void initState() {
    super.initState();
    _fetchAppInfo(); // Call the method in initState
  }

  Future<void> _fetchAppInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
      });
    } catch (e) {
      debugPrint("Failed to fetch app info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorRes.primaryColor.withOpacity(0.85),
              Colors.white.withOpacity(0.9),
              Colors.white,
            ],
            stops: const [0.0, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Image
                    ScaleTransition(
                      scale: controller.scaleAnimation,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: Image.asset(
                          'assets/images/book_lovers.png',
                          fit: BoxFit.cover,
                          width: Get.width,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Animated Title
                    SlideTransition(
                      position: controller.slideAnimation,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: const GlobalText(
                          str: 'Reading Is Fascinating',
                          color: ColorRes.primaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Animated Subtitle
                    SlideTransition(
                      position: controller.slideAnimation,
                      child: FadeTransition(
                        opacity: controller.fadeAnimation,
                        child: const GlobalText(
                          str: 'Dive into a world of endless knowledge',
                          color: ColorRes.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Animated Button
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(parent: controller.getAnimationController, curve: Curves.easeOutBack),
                        ),
                        child: ElevatedButton(
                          onPressed: controller.navigateToHome,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorRes.primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            elevation: 10,
                            shadowColor: ColorRes.primaryColor.withOpacity(0.4),
                          ),
                          child: const GlobalText(
                            str: 'Start Exploring',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Subtle Overlay Effect
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.5,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),

              // Version Text
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlobalText(
                      str: "Version: v$_version",
                      color: ColorRes.primaryColor.withOpacity(0.80),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}