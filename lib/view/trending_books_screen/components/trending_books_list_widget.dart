import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';

class TrendingBooksListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String bookName;
  final Color bookNameColor;
  final Color authorNameColor;
  final Color shortDescriptionColor;
  final Color borderColor;
  final Color backgroundColor;
  final String? imageUrl;
  final double imageSize;

  const TrendingBooksListWidget({
    required this.onTap,
    required this.bookName,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width,
              child: Material(
                color: Colors.transparent,
                shadowColor: Colors.black.withOpacity(1),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Container(
                  width: Get.width,
                  height: 205,
                  decoration: BoxDecoration(
                    color: ColorRes.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bookName,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: bookNameColor,
                      ),
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