import 'package:flutter/material.dart';
import 'package:pdf_viewer/view/widget/colors.dart';

class RecommendedBookListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title; // Changed to optional
  final String subTitle; // Changed to optional
  final Color titleColor; // Dynamic title color
  final Color subTitleColor; // Dynamic title color
  final Color borderColor; // Dynamic border color
  final Color backgroundColor;
  final String? imageUrl; // Optional image URL
  final double imageSize; // Image size

  const RecommendedBookListWidget({
    required this.onTap,
    required this.title, // Changed to optional
    required this.subTitle, // Changed to optional
    this.titleColor = ColorRes.primaryColor, // Default title color
    this.subTitleColor = ColorRes.textColor, // Default title color
    this.borderColor = ColorRes.borderColor, // Default border color
    this.backgroundColor = ColorRes.white, // Default background color
    this.imageUrl, // Image URL
    this.imageSize = 140.0, // Default image size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: InkWell(
              onTap: onTap,
              child: Material(
                color: Colors.transparent,
                elevation: 2.0,
                shadowColor: Colors.black.withOpacity(1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Container(
                  width: 60,
                  height: 100,
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
          ),
          const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: titleColor,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: subTitleColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}