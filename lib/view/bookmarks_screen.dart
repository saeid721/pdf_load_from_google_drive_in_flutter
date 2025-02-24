import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/pdf_controller.dart';
import '../global/constants/colors_resources.dart';
import '../model/book_model.dart';
import 'dwonload/download_screen.dart';
import 'home_screen.dart';
import 'url_pdf.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PdfController>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookmarks')),
      body: Obx(() => ListView.builder(
            itemCount: controller.bookmarks.length,
            itemBuilder: (ctx, i) =>
                _buildBookmarkItem(controller.bookmarks[i]),
          )),
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

  Widget _buildBookmarkItem(Bookmark bookmark) {
    final controller = Get.find<PdfController>();
    return ListTile(
      title: Text(bookmark.message),
      subtitle: Text(
        DateFormat('MMM dd, yyyy - hh:mm a').format(bookmark.timestamp),
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeBookmark(bookmark),
      ),
      onTap: () {
        controller.setPdfUrl(bookmark.pdfUrl);
        // We don't have the full book info here, so we'll need to find it from downloads
        final book = controller.downloadBooks.firstWhere(
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