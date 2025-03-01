import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../controller/pdf_controller.dart';
import '../../data/trending_books_list.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_progress_hub.dart';
import '../../global/widget/global_sizedbox.dart';
import '../download/components/download_model.dart';
import 'components/trending_books_list_widget.dart';

class TrendingBooksListScreen extends StatefulWidget {
  const TrendingBooksListScreen({super.key});

  @override
  State<TrendingBooksListScreen> createState() =>
      _TrendingBooksListScreenState();
}

class _TrendingBooksListScreenState extends State<TrendingBooksListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(builder: (pdfController) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: 'Trending Books List',
        ),
        body: ProgressHUD(
          inAsyncCall: pdfController.isLoading,
          child: GlobalContainer(
            height: size(context).height,
            width: size(context).width,
            color: ColorRes.backgroundColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
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
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      );
    });
  }
}
