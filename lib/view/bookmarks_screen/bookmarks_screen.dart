import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/pdf_controller.dart';
import '../../controller/bookmark_controller.dart';
import '../../controller/download_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../download/components/download_model.dart';
import '../download/download_screen.dart';
import '../home_screen.dart';
import '../url_pdf_screen.dart';
import 'components/bookmark_model.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.find();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: const Text('My Bookmarks',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
        actions: [
          Obx(() {
            if (bookmarkController.isDownloading.value) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: bookmarkController.downloadProgress.value,
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        final books = bookmarkController.bookmarks;

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
          itemCount: bookmarkController.bookmarks.length,
          itemBuilder: (ctx, i) =>
              _buildBookmarkItem(bookmarkController.bookmarks[i]),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => const HomeScreen());
          } else if (index == 1) {
            Get.to(() => const DownloadScreen());
          } else if (index == 2) {
            Get.to(() => const BookmarksScreen());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Download'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmarks'),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(BookmarkModel bookmark) {
    final PdfController pdfController = Get.find();
    final BookmarkController bookmarkController = Get.find();
    final DownloadController downloadController = Get.find();

    return ListTile(
      title: Text('Page ${bookmark.pageNumber}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bookmark.note,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            DateFormat('MMM dd, yyyy - hh:mm a').format(bookmark.dateAdded),
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Colors.red,
        onPressed: () => bookmarkController.removeBookmark(bookmark),
      ),
      onTap: () {
        pdfController.setPdfUrl(bookmark.pdfUrl);
        final book = downloadController.downloadBooks.firstWhere(
          (b) => b.pdfUrl == bookmark.pdfUrl,
          orElse: () => DownloadBooks(
            imageUrl: '',
            pdfUrl: bookmark.pdfUrl,
            bookName: 'Unknown Book',
            authorName: 'Unknown Author',
            shortDescription: '',
          ),
        );
        Get.to(() => UrlPdfScreen(book: book));
      },
    );
  }
}
