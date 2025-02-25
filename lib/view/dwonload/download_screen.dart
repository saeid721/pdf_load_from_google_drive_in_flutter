import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/pdf_controller.dart';
import '../bookmarks_screen/bookmarks_screen.dart';
import '../home_screen.dart';
import '../url_pdf.dart';
import 'components/download_books_list_widget.dart';
import 'components/download_model.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PdfController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Download Books')),
      body: Obx(() => ListView.builder(
            itemCount: controller.downloadBooks.length,
            itemBuilder: (ctx, i) =>
                _buildDownloadBookItem(controller, controller.downloadBooks[i]),
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  Widget _buildDownloadBookItem(
      PdfController controller, DownloadBooks downloadBooks) {
    return DownloadBookListWidget(
      onTap: () {
        controller.setPdfUrl(downloadBooks.pdfUrl);
        Get.find<PdfController>().setPdfUrl(downloadBooks.pdfUrl);
        Get.to(() => UrlPdfScreen(book: downloadBooks));
      },
      imageUrl: downloadBooks.imageUrl,
      bookName: downloadBooks.bookName,
      authorName: downloadBooks.authorName,
      shortDescription: downloadBooks.shortDescription,
    );
  }
}
