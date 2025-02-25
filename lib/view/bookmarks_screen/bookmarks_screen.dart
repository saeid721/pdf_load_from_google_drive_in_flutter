import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/pdf_controller.dart';
import '../../controller/bookmark_controller.dart';
import '../../controller/download_controller.dart';
import '../download/components/download_model.dart';
import '../download/download_screen.dart';
import '../home_screen.dart';
import '../url_pdf_screen.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookmarks')),
      body: Obx(
            () => ListView.builder(
          itemCount: bookmarkController.bookmarks.length,
          itemBuilder: (ctx, i) => _buildBookmarkItem(bookmarkController.bookmarks[i]),
        ),
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Download'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
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