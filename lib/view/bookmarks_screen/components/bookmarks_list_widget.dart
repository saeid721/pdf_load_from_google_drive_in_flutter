import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../global/constants/colors_resources.dart';

class BookmarksListWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String bookName;
  final int pageNumber;
  final String note;
  final DateTime dateAdded;

  const BookmarksListWidget({
    super.key,
    required this.onTap,
    required this.imageUrl,
    required this.bookName,
    required this.pageNumber,
    required this.note,
    required this.dateAdded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: ColorRes.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                width: 60,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 80,
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
                padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Page $pageNumber',
                          style: const TextStyle(
                            color: ColorRes.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy - hh:mm a').format(dateAdded),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 12,
                            color: ColorRes.textColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
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
                    const SizedBox(height: 3),
                    Text(
                      note,
                      style: const TextStyle(
                        fontSize: 12,
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