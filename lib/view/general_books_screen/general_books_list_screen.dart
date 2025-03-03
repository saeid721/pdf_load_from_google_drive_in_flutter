import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../../controller/pdf_controller.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/custom_bottom_navbar.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../data/general_books_list.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/global_progress_hub.dart';
import '../download/components/download_model.dart';
import 'components/general_books_list_widget.dart';

class GeneralBooksListScreen extends StatefulWidget {
  const GeneralBooksListScreen({super.key});

  @override
  State<GeneralBooksListScreen> createState() => _GeneralBooksListScreenState();
}

class _GeneralBooksListScreenState extends State<GeneralBooksListScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(builder: (pdfController) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const CustomAppBar(
          title: 'General Books List',
        ),
        body: ProgressHUD(
          inAsyncCall: pdfController.isLoading,
          child: GlobalContainer(
            height: size(context).height,
            width: size(context).width,
            color: ColorRes.backgroundColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: pdfController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : generalBooks.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        size: 70,
                                        color: ColorRes.primaryColor
                                            .withOpacity(0.3),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "No recommendations available",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ColorRes.textColor
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                                  controller: _scrollController,
                                  itemCount: generalBooks.length,
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 10),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    mainAxisExtent: 280,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    final book = generalBooks[index];

                                    // Staggered animation for grid items
                                    return AnimatedBuilder(
                                      animation: _animationController,
                                      builder: (context, child) {
                                        final delay = index * 0.1;
                                        final animation =
                                            Tween<double>(begin: 0, end: 1)
                                                .animate(
                                          CurvedAnimation(
                                            parent: _animationController,
                                            curve: Interval(
                                              0.4 + delay > 1.0
                                                  ? 1.0
                                                  : 0.4 + delay,
                                              0.7 + delay > 1.0
                                                  ? 1.0
                                                  : 0.7 + delay,
                                              curve: Curves.easeOut,
                                            ),
                                          ),
                                        );

                                        return FadeTransition(
                                          opacity: animation,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, 0.3),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: GeneralBookListWidget(
                                        onTap: () {
                                          pdfController.setPdfUrl(book.pdfUrl);
                                          Get.to(
                                            () => UrlPdfScreen(
                                              downloadBooks: DownloadBooks(
                                                imageUrl: book.imageUrl,
                                                pdfUrl: book.pdfUrl,
                                                bookName: book.bookName,
                                                authorName: book.authorName,
                                                shortDescription:
                                                    book.shortDescription ?? '',
                                              ),
                                            ),
                                            transition: Transition.rightToLeft,
                                            duration: const Duration(
                                                milliseconds: 300),
                                          );
                                        },
                                        imageUrl: book.imageUrl,
                                        bookName: book.bookName,
                                      ),
                                    );
                                  },
                                ),
                    ),
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
