import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/pdf_controller.dart';
import '../controller/bookmark_controller.dart';
import '../controller/download_controller.dart';
import '../controller/search_controller.dart';
import '../global/constants/colors_resources.dart';
import 'download/components/download_model.dart';

class UrlPdfScreen extends StatelessWidget {
  final DownloadBooks book;

  const UrlPdfScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    final bookmarkController = Get.find<BookmarkController>();
    final downloadController = Get.find<DownloadController>();
    final searchController = Get.find<PdfSearchController>();
    final pdfViewerController = PdfViewerController();

    pdfController.setPdfUrl(book.pdfUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.bookName,
            style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
        ), maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          Obx(() => downloadController.isDownloading.value
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: downloadController.downloadProgress.value,
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          )
              : IconButton(
            icon: Icon(
              downloadController.isBookDownloaded(book.pdfUrl)
                  ? Icons.download_done
                  : Icons.download,
            ), color: ColorRes.primaryColor,
            onPressed: () async {
              if (!downloadController.isBookDownloaded(book.pdfUrl)) {
                await downloadController.downloadAndSavePdf(book);
              } else {
                Get.snackbar(
                  'Already Downloaded',
                  '${book.bookName} is already in your downloads',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
          )),
          IconButton(
            icon: const Icon(Icons.bookmark_add), color: ColorRes.primaryColor,
            onPressed: () => _showAddBookmarkDialog(
                context, bookmarkController, searchController),
          ),
          IconButton(
            icon: const Icon(Icons.search), color: ColorRes.primaryColor,
            onPressed: () =>
                _showSearchDialog(context, searchController, pdfViewerController),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => searchController.isSearching.value
              ? Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.withOpacity(0.1),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Page ${searchController.currentPage.value}/${searchController.totalPages.value}',
                  style: TextStyle(color: Colors.blue[700]),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    searchController.toggleSearching(false);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
          )
              : const SizedBox.shrink()),
          Expanded(
            child: SfPdfViewer.network(
              book.pdfUrl,
              controller: pdfViewerController,
              onDocumentLoaded: (details) =>
                  searchController.setTotalPages(details.document.pages.count),
              onPageChanged: (details) =>
                  searchController.setCurrentPage(details.newPageNumber),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBookmarkDialog(
      BuildContext context,
      BookmarkController bookmarkController,
      PdfSearchController searchController
      ) {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 8.0,
        title: Row(
          children: [
            Icon(Icons.bookmark, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8.0),
            Text(
              'Bookmark Page ${searchController.currentPage.value}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: 'Add a Note',
              hintText: 'Enter your bookmark note here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: const EdgeInsets.all(12.0),
            ),
            maxLines: 3,
            keyboardType: TextInputType.text,
          ),
        ),
        actionsPadding:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                bookmarkController.addBookmark(
                  searchController.currentPage.value,
                  textController.text.trim(),
                );
                Navigator.pop(ctx);
              } else {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Please add a note')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 2.0,
            ),
            child: const Text(
              'Save Bookmark',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(
      BuildContext context,
      PdfSearchController searchController,
      PdfViewerController pdfViewerController,
      ) {
    final TextEditingController pageController = TextEditingController();
    String? errorMessage;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,
          title: Row(
            children: [
              Icon(Icons.search, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8.0),
              Text(
                'Go to Page (1-${searchController.totalPages.value})',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: TextField(
              controller: pageController,
              maxLines: 1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter page number',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixText: '/ ${searchController.totalPages.value}',
                suffixStyle: const TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.all(12.0),
                errorText: errorMessage,
              ),
              onChanged: (value) {
                final page = int.tryParse(value);
                setState(() {
                  if (page == null ||
                      page < 1 ||
                      page > searchController.totalPages.value) {
                    errorMessage =
                    'Enter a valid page (1-${searchController.totalPages.value})';
                  } else {
                    errorMessage = null;
                  }
                });
              },
            ),
          ),
          actionsPadding:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final page = int.tryParse(pageController.text);
                if (page != null &&
                    page > 0 &&
                    page <= searchController.totalPages.value) {
                  pdfViewerController.jumpToPage(page);
                  searchController.toggleSearching(true);
                  Navigator.pop(context);
                } else {
                  setState(() {
                    errorMessage = 'Invalid page number';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 2.0,
              ),
              child: const Text(
                'Go',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}