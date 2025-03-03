import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/constants/colors_resources.dart';

class TrendingBooksListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String bookName;
  final String? authorName;
  final String? shortDescription;
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
    this.authorName,
    this.shortDescription,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            splashColor: ColorRes.primaryColor.withOpacity(0.1),
            highlightColor: ColorRes.primaryColor.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover with gradient overlay
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'book-${bookName.hashCode}',
                        child: Container(
                          width: Get.width,
                          height: 225,
                          decoration: BoxDecoration(
                            color: ColorRes.primaryColor.withOpacity(0.1),
                            image: imageUrl != null
                                ? DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.cover,
                            )
                                : null,
                          ),
                          child: imageUrl == null
                              ? Icon(
                            Icons.book,
                            size: 50,
                            color: ColorRes.primaryColor.withOpacity(0.3),
                          )
                              : null,
                        ),
                      ),
                      // Gradient overlay for better text visibility
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Book information
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}
