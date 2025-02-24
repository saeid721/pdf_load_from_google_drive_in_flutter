import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/pdf_controller.dart';
import '../model/book_model.dart';

class UrlPdf extends StatelessWidget {
  final DownloadBooks? book;

  const UrlPdf({super.key, this.book});

  @override
  Widget build(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    final pdfViewerController = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          pdfController.isSearching.value
              ? 'Page ${pdfController.currentPage}/${pdfController.totalPages}'
              : book?.bookName ?? 'PDF Viewer',
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              if (book != null) {
                await pdfController.downloadAndSavePdf(book!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book information not available')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () => _showAddBookmarkDialog(context, pdfController),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                _showSearchDialog(context, pdfController, pdfViewerController),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        pdfController.pdfUrl.value,
        controller: pdfViewerController,
        onDocumentLoaded: (details) =>
        pdfController.totalPages.value = details.document.pages.count,
        onPageChanged: (details) =>
        pdfController.currentPage.value = details.newPageNumber,
      ),
    );
  }

  void _showAddBookmarkDialog(BuildContext context, PdfController controller) {
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
              'Bookmark Page ${controller.currentPage}',
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
                controller.addBookmark(
                  controller.currentPage.value,
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
      PdfController pdfController,
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
                'Go to Page (1-${pdfController.totalPages.value})',
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
              keyboardType:
              TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter page number',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixText: '/ ${pdfController.totalPages.value}',
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
                      page > pdfController.totalPages.value) {
                    errorMessage =
                    'Enter a valid page (1-${pdfController.totalPages.value})';
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
                    page <= pdfController.totalPages.value) {
                  pdfViewerController.jumpToPage(page);
                  pdfController.isSearching.value = true;
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