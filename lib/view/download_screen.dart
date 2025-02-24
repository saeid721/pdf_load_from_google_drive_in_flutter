import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pdf_controller.dart';
import '../model/book_model.dart';
import 'bookmarks_screen.dart';
import 'home_screen.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PdfController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Download Books')),
      body: Obx(() => ListView.builder(
        itemCount: controller.downloadBooks.length,
        itemBuilder: (ctx, i) => _buildDownloadBookItem(controller.downloadBooks[i]),
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
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Download'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookmarks'),
        ],
      ),
    );
  }

  Widget _buildDownloadBookItem(DownloadBooks downloadBooks) {
    return ListTile(
      title: Text('Book ${downloadBooks.bookName}'),
      subtitle: Text('Writer ${downloadBooks.authorName}'),
    );
  }
}