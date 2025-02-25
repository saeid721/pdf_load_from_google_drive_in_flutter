import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/download_controller.dart';
import '../../controller/pdf_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../bookmarks_screen/bookmarks_screen.dart';
import '../home_screen.dart';
import '../url_pdf_screen.dart';
import 'components/download_books_list_widget.dart';
import 'components/download_model.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final downloadController = Get.find<DownloadController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: const Text('Downloaded Books'),
        actions: [
          Obx(() {
            if (downloadController.isDownloading.value) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: downloadController.downloadProgress.value,
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
        final downloadBook = downloadController.downloadBooks;

        if (downloadBook.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download_done_rounded,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Book downloaded yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your downloaded downloadBook will appear here',
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
          itemCount: downloadBook.length,
          itemBuilder: (ctx, i) => _buildDownloadBookItem(
            downloadController,
            downloadBook[i],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.off(() => const HomeScreen());
          } else if (index == 1) {
          } else if (index == 2) {
            Get.off(() => const BookmarksScreen());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Downloads'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmarks'),
        ],
      ),
    );
  }

  Widget _buildDownloadBookItem(
      DownloadController downloadController, DownloadBooks downloadBook) {
    return Dismissible(
      key: Key(downloadBook.pdfUrl),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Delete Book'),
            content: Text(
                'Are you sure you want to delete "${downloadBook.bookName}"?\n\nThis will remove the PDF file from your device.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        downloadController.removeDownloadBook(downloadBook);
        Get.snackbar(
          'Book Deleted',
          '"${downloadBook.bookName}" has been removed from downloads',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: DownloadBookListWidget(
        onTap: () {
          Get.find<PdfController>().setPdfUrl(downloadBook.pdfUrl);
          Get.to(() => UrlPdfScreen(book: downloadBook));
        },
        imageUrl: downloadBook.imageUrl,
        bookName: downloadBook.bookName,
        authorName: downloadBook.authorName,
        shortDescription: downloadBook.shortDescription,
      ),
    );
  }
}
