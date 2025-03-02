import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';

class RecommendedBooksWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String bookName;
  final String authorName;
  final String shortDescription;
  final Color bookNameColor;
  final Color authorNameColor;
  final Color shortDescriptionColor;
  final Color borderColor;
  final Color backgroundColor;
  final String? imageUrl;
  final double imageSize;

  const RecommendedBooksWidget({
    required this.onTap,
    required this.bookName,
    required this.authorName,
    required this.shortDescription,
    this.bookNameColor = ColorRes.primaryColor,
    this.authorNameColor = ColorRes.textColor,
    this.shortDescriptionColor = ColorRes.textColor,
    this.borderColor = ColorRes.borderColor,
    this.backgroundColor = ColorRes.white,
    this.imageUrl,
    this.imageSize = 100.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorRes.white,
        elevation: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: Material(
                color: Colors.transparent,
                shadowColor: Colors.black.withOpacity(1),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Container(
                  width: Get.width,
                  height: 80,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
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
            const SizedBox(height: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: bookNameColor,
                      ),
                    ),
                    Text(
                      authorName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: authorNameColor,
                      ),
                    ),
                    Text(
                      shortDescription,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: shortDescriptionColor,
                      ),
                      maxLines: 2,
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