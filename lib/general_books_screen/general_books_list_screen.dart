import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../controller/pdf_controller.dart';
import '../../data/recommended_books_list.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_sizedbox.dart';
import '../view/download/components/download_model.dart';
import 'components/general_books_list_widget.dart';

class GeneralBooksListScreen extends StatelessWidget {
  const GeneralBooksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PdfController pdfController = Get.put(PdfController());

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: ColorRes.primaryColor),
        centerTitle: true,
        title: const Text(
          'General Books List',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalContainer(
                  width: Get.width,
                  color: ColorRes.backgroundColor,
                  child: GridView.builder(
                    itemCount: recommendedBooks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 263,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    itemBuilder: (ctx, index) {
                      final book = recommendedBooks[index];
                      return GeneralBookListWidget(
                        onTap: () {
                          pdfController.setPdfUrl(book.pdfUrl);
                          Get.to(() => UrlPdfScreen(
                                downloadBooks: DownloadBooks(
                                  imageUrl: book.imageUrl,
                                  pdfUrl: book.pdfUrl,
                                  bookName: book.bookName,
                                  authorName: book.authorName,
                                  shortDescription: book.shortDescription ?? '',
                                ),
                              ));
                        },
                        imageUrl: book.imageUrl,
                        bookName: book.bookName,
                      );
                    },
                  ),
                ),
                sizedBoxH(10),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
