import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/bookmarks_screen/bookmarks_screen.dart';
import 'package:pdf_viewer/view/download/download_screen.dart';
import 'package:pdf_viewer/view/home_screen.dart';
import '../constants/colors_resources.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleNavigation(index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
      ],
      selectedItemColor: ColorRes.primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  void _handleNavigation(int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Get.offAll(() => const HomeScreen());
        break;
      case 1:
        Get.offAll(() => const DownloadScreen());
        break;
      case 2:
        Get.offAll(() => const BookmarksScreen());
        break;
    }
  }
}