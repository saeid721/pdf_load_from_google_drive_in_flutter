import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../controller/pdf_controller.dart';
import '../../data/trending_books_list.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_sizedbox.dart';
import '../bookmarks_screen/bookmarks_screen.dart';
import '../download/components/download_model.dart';
import '../download/download_screen.dart';
import 'components/trending_books_list_widget.dart';

class TrendingBooksListScreen extends StatelessWidget {
  const TrendingBooksListScreen({super.key});

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
          'Trending Books List',
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
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalContainer(
                  width: Get.width,
                  color: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: GridView.builder(
                      itemCount: trendingBooks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 265,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (ctx, index) {
                        final book = trendingBooks[index];
                        return TrendingBooksListWidget(
                          onTap: () {
                            pdfController.setPdfUrl(book.pdfUrl);
                            Get.to(() => UrlPdfScreen(
                                  downloadBooks: DownloadBooks(
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
            Get.to(() => const TrendingBooksListScreen());
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
