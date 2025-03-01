import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/pdf_controller.dart';
import '../../controller/bookmark_controller.dart';
import '../../controller/download_controller.dart'; // Added for download progress
import '../../global/constants/colors_resources.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../download/components/download_model.dart';
import '../url_pdf_screen.dart';
import 'components/bookmark_model.dart';
import 'components/bookmarks_list_widget.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.find<PdfController>();
    final BookmarkController bookmarkController = Get.find<BookmarkController>();
    final DownloadController downloadController = Get.find<DownloadController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: const Text(
          'My Bookmarks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
        actions: [
          GetBuilder<DownloadController>(
            builder: (controller) {
              if (controller.isDownloading) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: controller.downloadProgress,
                        strokeWidth: 2,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: GetBuilder<BookmarkController>(
        builder: (controller) {
          final books = controller.bookmarks;

          if (books.isEmpty) {
            return Center(
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
            );
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (ctx, i) => _buildBookmarkItem(
              books[i],
              pdfController,
              bookmarkController,
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildBookmarkItem(
      BookmarkModel bookmark,
      PdfController pdfController,
      BookmarkController bookmarkController,
      ) {
    return Dismissible(
      key: Key(bookmark.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 10),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Delete Bookmark'),
            content: Text(
              'Are you sure you want to delete "${bookmark.note}"?\n\nThis will remove the Bookmark from your device.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
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
          '"${bookmark.note}" has been removed from Bookmark',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.grey[800],
          colorText: Colors.white,
        );
      },
      child: BookmarksListWidget(
        onTap: () {
          pdfController.setPdfUrl(bookmark.pdfUrl);
          Get.to(() => UrlPdfScreen(
            downloadBooks: DownloadBooks(
              imageUrl: bookmark.imageUrl,
              pdfUrl: bookmark.pdfUrl,
              bookName: bookmark.bookName,
              authorName: '',
              shortDescription: '',
            ),
          ));
        },
        imageUrl: bookmark.imageUrl,
        bookName: bookmark.bookName,
        pageNumber: bookmark.pageNumber,
        dateAdded: bookmark.dateAdded,
        note: bookmark.note,
      ),
    );
  }
}