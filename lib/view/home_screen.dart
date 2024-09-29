import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf.dart';
import 'package:pdf_viewer/view/widget/colors.dart';
import '../books_list/trending_books_list.dart';
import '../controller/pdf_controller.dart';
import 'side_ber_menu_screen.dart';
import 'widget/global_container.dart';
import 'widget/global_sizedbox.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              // Get.to(() => SignInScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const SideBerMenuWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                GlobalContainer(
                  width: Get.width,
                  backgroundColor: ColorRes.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: trendingBooks.map((book) {
                          return TrendingBooksListWidget(
                            onTap: () {
                              pdfController.setPdfUrl(book.pdfUrl);
                              Get.to(() => const UrlPdf());
                            },
                            imageUrl: book.imageUrl,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                sizedBoxH(10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Books',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorRes.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                GlobalContainer(
                  width: Get.width,
                  height: 400,
                  backgroundColor: ColorRes.backgroundColor,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: trendingBooks.map((trendingBooks) {
                          return RecommendedBookListWidget(
                            onTap: () {
                              pdfController.setPdfUrl(trendingBooks.pdfUrl);
                              Get.to(() => const UrlPdf());
                            },
                            imageUrl: trendingBooks.imageUrl,
                            title: 'স্বাধীনতা উত্তর বাংলাদেশ - প্রথম খণ্ড',
                            subTitle: 'পিনাকী ভট্টাচার্য',
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore, color: Colors.blue), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.book, color: Colors.blue), label: 'Reading'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark, color: Colors.grey), label: 'Bookmark'),
        ],
      ),
    );
  }
}
