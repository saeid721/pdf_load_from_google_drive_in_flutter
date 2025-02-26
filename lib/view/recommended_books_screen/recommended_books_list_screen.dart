import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../controller/pdf_controller.dart';
import '../../data/recommended_books_list.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_sizedbox.dart';
import '../bookmarks_screen/bookmarks_screen.dart';
import '../download/components/download_model.dart';
import '../download/download_screen.dart';
import '../trending_books_screen/components/trending_books_list_widget.dart';

class RecommendedBooksListScreen extends StatelessWidget {
  const RecommendedBooksListScreen({super.key});

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
          'Recommended Books List',
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
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5  ),
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
                      return TrendingBooksListWidget(
                        onTap: () {
                          pdfController.setPdfUrl(book.pdfUrl);
                          Get.to(() => UrlPdfScreen(
                                book: DownloadBooks(
                                  imageUrl: book.imageUrl,
                                  pdfUrl: book.pdfUrl,
                                  bookName: book.bookName,
                                  authorName: book.authorName,
                                  shortDescription:
                                      book.shortDescription ?? '',
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => const RecommendedBooksListScreen());
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
}
