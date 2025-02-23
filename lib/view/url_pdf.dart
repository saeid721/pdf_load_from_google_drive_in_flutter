import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/pdf_controller.dart';

class UrlPdf extends StatelessWidget {
  const UrlPdf({super.key});

  @override
  Widget build(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    final pdfViewerController = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              pdfController.isSearching.value
                  ? 'Page ${pdfController.currentPage}/${pdfController.totalPages}'
                  : 'PDF Viewer',
            )),
        actions: [
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
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Bookmark Page ${controller.currentPage}'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(labelText: 'Add note'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addBookmark(
                  controller.currentPage.value, textController.text);
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(
    BuildContext context,
    PdfController pdfController, // Assuming this has totalPages and isSearching
    PdfViewerController pdfViewerController,
  ) {
    final TextEditingController pageController = TextEditingController();
    String? errorMessage;

    showDialog(
      context: context,
      barrierDismissible: true, // Dismiss on tapping outside
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          elevation: 8.0, // Shadow for depth
          backgroundColor: Colors.white, // Clean background
          title: Row(
            children: [
              const Icon(Icons.search, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text(
                'Go to Page (1-${pdfController.totalPages.value})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: pageController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Enter page number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  suffixText: '/ ${pdfController.totalPages.value}',
                  suffixStyle: const TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  errorText: errorMessage, // Display validation error
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
              const SizedBox(height: 8),
              Text(
                'Jump to any page instantly.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 2,
              ),
              child: const Text(
                'Go',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }
}
