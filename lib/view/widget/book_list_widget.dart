import 'package:flutter/material.dart';

class HomeBookListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String? title; // Changed to optional
  final Color titleColor; // Dynamic title color
  final Color borderColor; // Dynamic border color
  final Color backgroundColor;
  final String? imageUrl; // Optional image URL
  final double imageSize; // Image size

  const HomeBookListWidget({
    required this.onTap,
    this.title, // Changed to optional
    this.titleColor = Colors.red, // Default title color
    this.borderColor = Colors.grey, // Default border color
    this.backgroundColor = Colors.white, // Default background color
    this.imageUrl, // Image URL
    this.imageSize = 140.0, // Default image size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Material(
              color: Colors.transparent,
              elevation: 1,
              shadowColor: Colors.black.withOpacity(1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              child: Container(
                width: 150,
                height: 210,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  border: Border.all(color: borderColor, width: 1.0),
                  image: imageUrl != null
                      ? DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5), // Space between image and title
          if (title != null) // Check if title is not null before displaying
            Text(
              title!,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
        ],
      ),
    );
  }
}
