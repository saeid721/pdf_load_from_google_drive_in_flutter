import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/download_controller.dart';
import '../../controller/pdf_controller.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_sizedbox.dart';
import '../url_pdf_screen.dart';
import 'components/download_books_list_widget.dart';
import 'components/download_model.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloadController>(builder: (downloadController) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Downloaded Books',
          ),
          body: downloadController.downloadBooks.isEmpty
              ? Center(
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
                )
              : GlobalContainer(
                  height: size(context).height,
                  width: size(context).width,
                  color: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.builder(
                      itemCount: downloadController.downloadBooks.length,
                      itemBuilder: (ctx, i) => _buildDownloadBookItem(
                        downloadController,
                        downloadController.downloadBooks[i],
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
        );
      },
    );
  }

  Widget _buildDownloadBookItem(
      DownloadController downloadController, DownloadBooks book) {
    return Dismissible(
      key: Key(book.pdfUrl),
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
            title: const Text('Delete Book'),
            content: Text(
                'Are you sure you want to delete "${book.bookName}"?\n\nThis will remove the PDF file from your device.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete',
                      style: TextStyle(color: ColorRes.red))),
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
          backgroundColor: Colors.grey[800],
          colorText: Colors.white,
        );
      },
      child: DownloadBookListWidget(
        onTap: () {
          final pdfController = Get.find<PdfController>();
          pdfController.setPdfUrl(book.pdfUrl);
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



