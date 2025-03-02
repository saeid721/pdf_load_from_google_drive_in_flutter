import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/view/bookmarks_screen/bookmarks_screen.dart';
import '/view/download/download_screen.dart';
import '/view/home_screen.dart';
import '../constants/colors_resources.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => _handleNavigation(index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorRes.primaryColor,
          unselectedItemColor: Colors.grey.withOpacity(0.6),
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
          items: [
            _buildNavItem(Icons.explore, 'Explore', 0),
            _buildNavItem(Icons.download, 'Downloads', 1),
            _buildNavItem(Icons.bookmark, 'Bookmarks', 2),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedIndex == index
              ? ColorRes.primaryColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Icon(
          icon,
          size: 26,
          color: _selectedIndex == index
              ? ColorRes.primaryColor
              : Colors.grey.withOpacity(0.6),
        ),
      ),
      label: label,
    );
  }

  void _handleNavigation(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index; // Update state
    });

    switch (index) {
      case 0:
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400),
        );
        break;
      case 1:
        Get.offAll(
          () => const DownloadScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400),
        );
        break;
      case 2:
        Get.offAll(
          () => const BookmarksScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400),
        );
        break;
    }
  }
}
