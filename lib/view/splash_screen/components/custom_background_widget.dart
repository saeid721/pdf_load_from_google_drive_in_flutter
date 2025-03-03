import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8AC4FF), // Start Color
            Color(0xFFD0EFFF), // End Color
          ],
        ),
      ),
      child: Stack(
        children: [
          // Top-left circle
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5FE).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Bottom-right circle
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFE1F5FE).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Main content
          child,
        ],
      ),
    );
  }
}
