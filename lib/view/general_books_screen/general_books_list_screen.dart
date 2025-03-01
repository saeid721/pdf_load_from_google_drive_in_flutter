import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../../controller/pdf_controller.dart';
import '../../../data/recommended_books_list.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/custom_bottom_navbar.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/global_progress_hub.dart';
import '../download/components/download_model.dart';
import 'components/general_books_list_widget.dart';

class GeneralBooksListScreen extends StatefulWidget {
  const GeneralBooksListScreen({super.key});

  @override
  State<GeneralBooksListScreen> createState() => _GeneralBooksListScreenState();
}

class _GeneralBooksListScreenState extends State<GeneralBooksListScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(builder: (pdfController) {
      return Scaffold(
        appBar: const CustomAppBar(
          title: 'General Books List',
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
                      child: GridView.builder(
                        itemCount: recommendedBooks
                            .length, // Should be generalBooks.length
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
                          final book = recommendedBooks[
                              index]; // Should use generalBooks[index]
                          return GeneralBookListWidget(
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
