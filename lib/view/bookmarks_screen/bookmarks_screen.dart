import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/pdf_controller.dart';
import '../../controller/bookmark_controller.dart';
import '../../controller/download_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_sizedbox.dart';
import '../download/components/download_model.dart';
import '../url_pdf_screen.dart';
import 'components/bookmark_model.dart';
import 'components/bookmarks_list_widget.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.find<PdfController>();
    final DownloadController downloadController =
        Get.find<DownloadController>();

    return GetBuilder<BookmarkController>(builder: (bookmarkController) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'My Bookmarks',
          ),
          body: bookmarkController.bookmarks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No bookmarks yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your bookmarks will appear here',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : GlobalContainer(
                  height: size(context).height,
                  width: size(context).width,
                  color: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                      itemCount: bookmarkController.bookmarks.length,
                      itemBuilder: (ctx, i) => _buildBookmarkItem(
                        bookmarkController,
                        bookmarkController.bookmarks[i],
                        pdfController,
                        downloadController,
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
        );
      },
    );
  }

  Widget _buildBookmarkItem(
    BookmarkController bookmarkController,
    BookmarkModel bookmark,
    PdfController pdfController,
    DownloadController downloadController,
  ) {
    final downloadedBook =
        downloadController.getDownloadedBook(bookmark.pdfUrl);

    return Dismissible(
      key: Key(bookmark.id.toString()),
      background: Container(
        color: ColorRes.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        child: const Icon(Icons.delete, color: ColorRes.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Delete Bookmark'),
            content: Text(
              'Are you sure you want to delete "${bookmark.note}"?\n\nThis will remove the bookmark from your device.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: ColorRes.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        bookmarkController.removeBookmark(bookmark);
        Get.snackbar(
          'Bookmark Deleted',
          '"${bookmark.note}" has been removed from bookmarks',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey[800],
          colorText: Colors.white,
        );
      },
      child: BookmarksListWidget(
        onTap: () {
          pdfController.setPdfUrl(bookmark.pdfUrl);
          Get.to(() => UrlPdfScreen(
                downloadBooks: downloadedBook ??
                    DownloadBooks(
                      imageUrl: bookmark.imageUrl ?? '',
                      pdfUrl: bookmark.pdfUrl,
                      bookName: bookmark.bookName,
                      authorName: '', // Fallback if not in DownloadController
                      shortDescription:
                          '', // Fallback if not in DownloadController
                    ),
              ));
        },
        imageUrl: bookmark.imageUrl ?? '',
        bookName: bookmark.bookName,
        pageNumber: bookmark.pageNumber,
        dateAdded: bookmark.dateAdded,
        note: bookmark.note,
      ),
    );
  }
}
