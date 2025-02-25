import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../controller/pdf_controller.dart';
import '../data/recommended_books_list.dart';
import '../data/trending_books_list.dart';
import '../global/constants/colors_resources.dart';
import '../global/widget/global_container.dart';
import '../global/widget/global_sizedbox.dart';
import 'bookmarks_screen/bookmarks_screen.dart';
import 'custom_drawer_screen.dart';
import 'download/components/download_model.dart';
import 'download/download_screen.dart';
import 'widget/recommended_books_list_widget.dart';
import 'widget/trending_books_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          'PDF Library',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: ColorRes.primaryColor,
          ),
        ),
      ),
      drawer: const CustomDrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Trending Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GlobalContainer(
                  width: Get.width,
                  color: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: trendingBooks.map((book) {
                          return TrendingBooksListWidget(
                            onTap: () {
                              pdfController.setPdfUrl(book.pdfUrl);
                              Get.to(() => UrlPdfScreen(
                                book: DownloadBooks(
                                  imageUrl: book.imageUrl,
                                  pdfUrl: book.pdfUrl,
                                  bookName: book.bookName,
                                  authorName: book.authorName,
                                  shortDescription: '',
                                ),
                              ));
                            },
                            imageUrl: book.imageUrl,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                sizedBoxH(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorRes.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GlobalContainer(
                  width: Get.width,
                  color: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: recommendedBooks.map((recommendedBooks) {
                          return RecommendedBookListWidget(
                            onTap: () {
                              pdfController.setPdfUrl(recommendedBooks.pdfUrl);
                              Get.to(() => UrlPdfScreen(
                                book: DownloadBooks(
                                  imageUrl: recommendedBooks.imageUrl,
                                  pdfUrl: recommendedBooks.pdfUrl,
                                  bookName: recommendedBooks.bookName,
                                  authorName: recommendedBooks.authorName,
                                  shortDescription: recommendedBooks.shortDescription ?? '',
                                ),
                              ));
                            },
                            imageUrl: recommendedBooks.imageUrl,
                            bookName: recommendedBooks.bookName,
                            authorName: recommendedBooks.authorName,
                            shortDescription:
                                recommendedBooks.shortDescription ?? '',
                          );
                        }).toList(),
                      ),
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
}
