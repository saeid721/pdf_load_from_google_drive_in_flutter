import 'package:flutter/material.dart';

class HomeScreenInkWellWidget extends StatelessWidget {
  const HomeScreenInkWellWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.title,
  });

  final VoidCallback onTap;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 180,
        height: 120,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: color,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}