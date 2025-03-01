import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';

class DownloadBookListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String bookName;
  final String authorName;
  final String shortDescription;

  const DownloadBookListWidget({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.bookName,
    required this.authorName,
    required this.shortDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorRes.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.book,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            // Book Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5,right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookName,
                      style: const TextStyle(
                        color: ColorRes.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      authorName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorRes.textColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      shortDescription,
                      style: const TextStyle(
                        fontSize: 10,
                        color: ColorRes.textColor,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
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