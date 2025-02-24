import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_container.dart';

class DownloadBookListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String bookName; // Changed to optional
  final String authorName; // Changed to optional
  final String shortDescription; // Changed to optional
  final Color bookNameColor; // Dynamic title color
  final Color authorNameColor; // Dynamic author color
  final Color shortDescriptionColor; // Dynamic description color
  final Color borderColor; // Dynamic border color
  final Color backgroundColor;
  final String? imageUrl; // Optional image URL
  final double imageSize; // Image size

  const DownloadBookListWidget({
    required this.onTap,
    required this.bookName, // Changed to optional
    required this.authorName, // Changed to optional
    required this.shortDescription, // Changed to optional
    this.bookNameColor = ColorRes.primaryColor, // Default title color
    this.authorNameColor = ColorRes.textColor, // Default author color
    this.shortDescriptionColor =
        ColorRes.textColor, // Default description color
    this.borderColor = ColorRes.borderColor, // Default border color
    this.backgroundColor = ColorRes.white, // Default background color
    this.imageUrl, // Image URL
    this.imageSize = 100.0, // Default image size
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GlobalContainer(
        width: Get.width,
        color: Colors.grey[100]!,
        bottomBorderColor: ColorRes.borderColor,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
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
                    width: Get.width,
                    height: 80,
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
