import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../controller/pdf_controller.dart';
import '../../data/recommended_books_list.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/custom_bottom_navbar.dart';
import '../../global/widget/global_container.dart';
import '../../global/widget/global_progress_hub.dart';
import '../../global/widget/global_sizedbox.dart';
import '../download/components/download_model.dart';
import 'components/recommended_books_list_widget.dart';

class RecommendedBooksListScreen extends StatefulWidget {
  const RecommendedBooksListScreen({super.key});

  @override
  State<RecommendedBooksListScreen> createState() =>
      _RecommendedBooksListScreenState();
}

class _RecommendedBooksListScreenState extends State<RecommendedBooksListScreen>
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
          title: 'Recommended Books',
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
                          : recommendedBooks.isEmpty
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
                                  itemCount: recommendedBooks.length,
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 16),
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                    mainAxisExtent: 280,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    final book = recommendedBooks[index];

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
                                      child: RecommendedBookListWidget(
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
                                        authorName: book.authorName,
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
