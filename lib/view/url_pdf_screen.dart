import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/bookmark_controller.dart';
import '../controller/download_controller.dart';
import '../controller/search_controller.dart';
import '../global/constants/colors_resources.dart';
import '../global/dialog_helper.dart';
import 'download/components/download_model.dart';

class UrlPdfScreen extends StatelessWidget {
  final DownloadBooks downloadBooks;

  const UrlPdfScreen({super.key, required this.downloadBooks});

  @override
  Widget build(BuildContext context) {
    final bookmarkController = Get.find<BookmarkController>();
    final downloadController = Get.find<DownloadController>();
    final searchController = Get.find<PdfSearchController>();
    final pdfViewerController = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: Text(downloadBooks.bookName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ColorRes.primaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        actions: [
          GetBuilder<DownloadController>(
            builder: (controller) {
              if (downloadController.isDownloading) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: downloadController.downloadProgress,
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return IconButton(
                icon: Icon(
                  controller.isBookDownloaded(downloadBooks.pdfUrl)
                      ? Icons.download_done
                      : Icons.download,
                ),
                color: ColorRes.primaryColor,
                onPressed: () async {
                  if (!controller.isBookDownloaded(downloadBooks.pdfUrl)) {
                    await controller.downloadAndSavePdf(downloadBooks);
                  } else {
                    Get.snackbar(
                      'Already Downloaded',
                      '${downloadBooks.bookName} is already in your downloads',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: () => DialogHelper.showAddBookmarkDialog(
              context: context,
              bookName: downloadBooks.bookName,
              bookmarkController: bookmarkController,
              searchController: searchController,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => DialogHelper.showSearchDialog(
              context: context,
              searchController: searchController,
              pdfViewerController: pdfViewerController,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<PdfSearchController>( builder: (controller) {
              return searchController.isSearching.value
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.blue.withOpacity(0.1),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.blue[700], size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Page ${controller.currentPage}/${controller.totalPages}',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              controller.toggleSearching(false);
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
          Expanded(
            child: SfPdfViewer.network(
              downloadBooks.pdfUrl,
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
}
