import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/search_controller.dart';
import '../controller/bookmark_controller.dart';

class DialogHelper {
  // Bookmark Dialog
  static void showAddBookmarkDialog({
    required BuildContext context,
    required String bookName,
    required BookmarkController bookmarkController,
    required PdfSearchController searchController,
  }) {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        title: Row(
          children: [
            Icon(Icons.bookmark, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              'Bookmark Page ${searchController.currentPage.value}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Add a Note',
            hintText: 'Enter your bookmark note...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                bookmarkController.addBookmark(
                  pageNumber: searchController.currentPage.value,
                  bookName: bookName,
                  note: textController.text.trim(),
                );
                Navigator.pop(ctx);
              } else {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Please add a note')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Search/Go to Page Dialog
  static void showSearchDialog({
    required BuildContext context,
    required PdfSearchController searchController,
    required PdfViewerController pdfViewerController,
  }) {
    final TextEditingController pageController = TextEditingController();
    String? errorMessage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          title: Row(
            children: [
              Icon(Icons.search, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                'Go to Page (1-${searchController.totalPages.value})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter page number',
              suffixText: '/ ${searchController.totalPages.value}',
              errorText: errorMessage,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              final page = int.tryParse(value);
              setState(() {
                if (page == null || page < 1 || page > searchController.totalPages.value) {
                  errorMessage = 'Enter a valid page (1-${searchController.totalPages.value})';
                } else {
                  errorMessage = null;
                }
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final page = int.tryParse(pageController.text);
                if (page != null && page > 0 && page <= searchController.totalPages.value) {
                  pdfViewerController.jumpToPage(page);
                  searchController.toggleSearching(true);
                  Navigator.pop(context);
                } else {
                  setState(() => errorMessage = 'Invalid page number');
                }
              },
              child: const Text('Go'),
            ),
          ],
        ),
      ),
    );
  }
}