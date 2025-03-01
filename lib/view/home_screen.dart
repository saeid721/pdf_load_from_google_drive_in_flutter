import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pdf_controller.dart';
import '../data/general_books_list.dart';
import '../data/recommended_books_list.dart';
import '../data/trending_books_list.dart';
import '../general_books_screen/components/general_books_widget.dart';
import '../general_books_screen/general_books_list_screen.dart';
import '../global/constants/colors_resources.dart';
import '../global/widget/custom_bottom_navbar.dart';
import '../global/widget/global_container.dart';
import '../global/widget/global_sizedbox.dart';
import 'custom_drawer_screen.dart';
import 'download/components/download_model.dart';
import 'recommended_books_screen/components/recommended_books_widget.dart';
import 'recommended_books_screen/recommended_books_list_screen.dart';
import 'trending_books_screen/components/trending_books_widget.dart';
import 'trending_books_screen/trending_books_list_screen.dart';
import 'url_pdf_screen.dart';

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
            fontSize: 18,
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
                      onTap: () {
                        Get.to(() => const TrendingBooksListScreen());
                      },
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
                          return TrendingBooksWidget(
                            onTap: () {
                              pdfController.setPdfUrl(book.pdfUrl);
                              Get.to(() => UrlPdfScreen(
                                    downloadBooks: DownloadBooks(
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
                      onTap: () {
                        Get.to(() => const RecommendedBooksListScreen());
                      },
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
                    padding: const EdgeInsets.only(right: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: recommendedBooks.map((recommendedBooks) {
                          return RecommendedBooksWidget(
                            onTap: () {
                              pdfController.setPdfUrl(recommendedBooks.pdfUrl);
                              Get.to(() => UrlPdfScreen(
                                    downloadBooks: DownloadBooks(
                                      imageUrl: recommendedBooks.imageUrl,
                                      pdfUrl: recommendedBooks.pdfUrl,
                                      bookName: recommendedBooks.bookName,
                                      authorName: recommendedBooks.authorName,
                                      shortDescription:
                                          recommendedBooks.shortDescription ??
                                              '',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'General Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const GeneralBooksListScreen());
                      },
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
                    padding: const EdgeInsets.only(right: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: generalBooks.map((generalBooks) {
                          return GeneralBooksWidget(
                            onTap: () {
                              pdfController.setPdfUrl(generalBooks.pdfUrl);
                              Get.to(() => UrlPdfScreen(
                                downloadBooks: DownloadBooks(
                                  imageUrl: generalBooks.imageUrl,
                                  pdfUrl: generalBooks.pdfUrl,
                                  bookName: generalBooks.bookName,
                                  authorName: generalBooks.authorName,
                                  shortDescription:
                                  generalBooks.shortDescription ??
                                      '',
                                ),
                              ));
                            },
                            imageUrl: generalBooks.imageUrl,
                            bookName: generalBooks.bookName,
                            authorName: generalBooks.authorName,
                            shortDescription:
                            generalBooks.shortDescription ?? '',
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
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
