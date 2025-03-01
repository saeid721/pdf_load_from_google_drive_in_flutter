import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/download_controller.dart';
import '../../controller/pdf_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/custom_bottom_navbar.dart';
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
        title: const Text(
          'Downloaded Books',
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
                        color: ColorRes.textColor,
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
      body: GetBuilder<DownloadController>(
        builder: (controller) {
          final books = controller.downloadBooks;

          if (books.isEmpty) {
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
                    'No books downloaded yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your downloaded books will appear here',
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
            itemBuilder: (ctx, i) => _buildDownloadBookItem(
              controller,
              books[i],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildDownloadBookItem(
      DownloadController downloadController, DownloadBooks book) {
    return Dismissible(
      key: Key(book.pdfUrl),
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
            title: const Text('Delete Book'),
            content: Text(
                'Are you sure you want to delete "${book.bookName}"?\n\nThis will remove the PDF file from your device.'),
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
        downloadController.removeDownloadBook(book);
        Get.snackbar(
          'Book Deleted',
          '"${book.bookName}" has been removed from downloads',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: DownloadBookListWidget(
        onTap: () {
          Get.find<PdfController>().setPdfUrl(book.pdfUrl);
          Get.to(() => UrlPdfScreen(downloadBooks: book));
        },
        imageUrl: book.imageUrl,
        bookName: book.bookName,
        authorName: book.authorName,
        shortDescription: book.shortDescription,
      ),
    );
  }
}