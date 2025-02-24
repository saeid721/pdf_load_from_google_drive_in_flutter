import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/pdf_controller.dart';
import '../model/book_model.dart';
import 'download_screen.dart';
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
        currentIndex: 0,
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
    return ListTile(
      title: Text('Page ${bookmark.page}: ${bookmark.message}'),
      subtitle: Text(
        DateFormat('MMM dd, yyyy - hh:mm a').format(bookmark.timestamp),
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => controller.removeBookmark(bookmark),
      ),
      onTap: () {
        controller.setPdfUrl(bookmark.pdfUrl);
        Get.to(() => const UrlPdf());
      },
    );
  }
}
