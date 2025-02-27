import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../global/constants/colors_resources.dart';
import '../global/constants/enum.dart';
import '../global/constants/images.dart';
import '../global/widget/global_image_loader.dart';
import '../global/widget/global_text.dart';
import '../model/model.dart';
import 'contact_screen/contact_screen.dart';
import 'home_screen.dart';
import 'privacy_policy_screen/privacy_policy_screen.dart';
import 'weathers/weather_screen.dart';

class CustomDrawerScreen extends StatefulWidget {
  const CustomDrawerScreen({super.key});

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {
  int isClick = 0;
  final List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.homeInc, text: 'Home'),
    GlobalMenuModel(img: Images.contactInc, text: 'Contact Us'),
    // GlobalMenuModel(img: Images.informationInc, text: 'About Us'),
    GlobalMenuModel(img: Images.shareInc, text: 'Share'),
    GlobalMenuModel(img: Images.ratingInc, text: 'Rating'),
    GlobalMenuModel(img: Images.policyInc, text: 'Privacy & Policy'),
    GlobalMenuModel(img: Images.policyInc, text: 'Weather'),
  ];

  // Function to handle app sharing
  void _shareApp() {
    const String message = "Check out this amazing app! [Your App Link Here]";
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: Get.height,
        width: Get.width,
        color: ColorRes.white,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 160,
                  padding: const EdgeInsets.only(
                      left: 20, right: 10, top: 50, bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorRes.white100,
                    border:
                        Border.all(color: ColorRes.primaryColor, width: 0.3),
                  ),
                  child: const ClipRRect(
                    child: GlobalImageLoader(
                      imagePath: 'assets/images/logo.png',
                      width: 200,
                      imageFor: ImageFor.asset,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItem.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            isClick = index;
                          });
                          log('Index: $index');
                          switch (index) {
                            case 0:
                              Get.to(() => const HomeScreen());
                              break;
                            case 1:
                              Get.to(() => const ContactScreen());
                              break;
                            case 2:
                              _shareApp(); // Trigger share app function
                              break;
                            case 3:
                              // Add any action for Rating here
                              break;
                            case 4:
                              Get.to(() => const AppPrivacyPolicyScreen());
                              break;
                            case 5:
                              Get.to(() => const WeatherScreen());
                              break;
                          }
                        },
                        child: Container(
                          width: Get.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isClick == index
                                ? ColorRes.primaryColor
                                : Colors.white,
                          ),
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              GlobalImageLoader(
                                imagePath: menuItem[index].img,
                                height: 20,
                                width: 20,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(width: 10),
                              GlobalText(
                                str: menuItem[index].text,
                                color: isClick == index
                                    ? ColorRes.white
                                    : ColorRes.black,
                                fontSize: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Bottom Description and Loader
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalText(
                      str: 'Version: 1.0.1',
                      color: ColorRes.textColor,
                      fontSize: 13,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
