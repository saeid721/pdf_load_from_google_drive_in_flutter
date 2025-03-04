import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pdf_controller.dart';
import '../data/recommended_books_list.dart';
import '../data/trending_books_list.dart';
import '../global/constants/images.dart';
import '../global/custom_app_bar.dart';
import '../global/widget/global_progress_hub.dart';
import '../global/widget/global_text.dart';
import '../model/model.dart';
import 'category_screen/category_screen.dart';
import 'category_screen/components/category_menu_widget.dart';
import 'general_books_screen/general_books_list_screen.dart';
import '../global/constants/colors_resources.dart';
import '../global/shimmer/shimmer_widget.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PdfController pdfController = Get.put(PdfController());
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.appLogo, text: 'English Books'),
    GlobalMenuModel(img: Images.appLogo, text: 'অনুবাদ বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'বাংলাদেশ ও মুক্তিযুদ্ধ বিষয়ক'),
    GlobalMenuModel(img: Images.appLogo, text: 'ইসলামিক বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'আত্মউন্নয়নমূলক বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'আত্মজীবনী ও স্মৃতিকথা'),
    GlobalMenuModel(img: Images.appLogo, text: 'গণিত, বিজ্ঞান ও প্রযুক্তি'),
    GlobalMenuModel(img: Images.appLogo, text: 'সায়েন্স ফিকশন / বৈজ্ঞানিক কল্পকাহিনী'),
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    pdfController.fetchData((loading) {
      if (mounted) {
        setState(() {
          isLoading = loading;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PDF Library',
      ),
      drawer: const CustomDrawerScreen(),
      body: ProgressHUD(
        inAsyncCall: pdfController.isLoading,
        child: GlobalContainer(
          height: size(context).height,
          width: size(context).width,
          color: ColorRes.backgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trending Books Section
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
                  isLoading
                      ? _buildTrendingShimmer()
                      : GlobalContainer(
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

                  // Recommended Books Section
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
                  isLoading
                      ? _buildRecommendedShimmer()
                      : GlobalContainer(
                          width: Get.width,
                          color: ColorRes.backgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: recommendedBooks.map((book) {
                                  return RecommendedBooksWidget(
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
                                    authorName: book.authorName,
                                    shortDescription:
                                        book.shortDescription ?? '',
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),

                  sizedBoxH(10),

                  // Category Section
                  const Center(
                    child: Text(
                      'CATEGORY',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorRes.primaryColor,
                      ),
                    ),
                  ),
                  sizedBoxH(3),

                  GlobalContainer(
                    width: Get.width,
                    color: ColorRes.backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            GridView.builder(
                                itemCount: menuItem.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 90),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 1:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 2:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 3:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 4:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 5:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 6:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                        case 7:
                                          Get.to(() =>
                                              const GeneralBooksListScreen());
                                          break;
                                      }
                                    },
                                    child: CategoryMenuWidget(
                                      // height: 30,
                                      // width: 30,
                                      maxLines: 3,
                                      //imagePath: menuItem[index].img,
                                      text: menuItem[index].text,
                                      subText: menuItem[index].subText ?? "",
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),

                  sizedBoxH(10),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const CategoryScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorRes.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 10,
                      shadowColor: ColorRes.white.withOpacity(0.4),
                    ),
                    child: const GlobalText(
                      str: 'See All Category',
                      color: ColorRes.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  )),
                  // sizedBoxH(10),
                  //
                  // // General Books Section
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       'General Books',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //         color: ColorRes.primaryColor,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         Get.to(() => const GeneralBooksListScreen());
                  //       },
                  //       child: const Padding(
                  //         padding: EdgeInsets.only(right: 10),
                  //         child: Text(
                  //           'See All',
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w600,
                  //             color: ColorRes.primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // isLoading
                  //     ? _buildGeneralShimmer()
                  //     : GlobalContainer(
                  //         width: Get.width,
                  //         color: ColorRes.backgroundColor,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(right: 5),
                  //           child: SingleChildScrollView(
                  //             scrollDirection: Axis.vertical,
                  //             child: Column(
                  //               children: generalBooks.map((book) {
                  //                 return GeneralBooksWidget(
                  //                   onTap: () {
                  //                     pdfController.setPdfUrl(book.pdfUrl);
                  //                     Get.to(() => UrlPdfScreen(
                  //                           downloadBooks: DownloadBooks(
                  //                             imageUrl: book.imageUrl,
                  //                             pdfUrl: book.pdfUrl,
                  //                             bookName: book.bookName,
                  //                             authorName: book.authorName,
                  //                             shortDescription:
                  //                                 book.shortDescription ?? '',
                  //                           ),
                  //                         ));
                  //                   },
                  //                   imageUrl: book.imageUrl,
                  //                   bookName: book.bookName,
                  //                   authorName: book.authorName,
                  //                   shortDescription: book.shortDescription ?? '',
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  // Shimmer for Trending Books (Horizontal)
  Widget _buildTrendingShimmer() {
    return GlobalContainer(
      width: Get.width,
      color: ColorRes.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              3, // Simulate 3 items
              (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: ShimmerWidget.rectangular(height: 150, width: 100),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer for Recommended Books (Vertical)
  Widget _buildRecommendedShimmer() {
    return GlobalContainer(
      width: Get.width,
      color: ColorRes.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Column(
          children: List.generate(
            2, // Simulate 2 items
            (index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ShimmerWidget.rectangular(
                  height: 100, width: double.infinity),
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer for General Books (Vertical)
  Widget _buildGeneralShimmer() {
    return GlobalContainer(
      width: Get.width,
      color: ColorRes.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Column(
          children: List.generate(
            2, // Simulate 2 items
            (index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ShimmerWidget.rectangular(
                  height: 100, width: double.infinity),
            ),
          ),
        ),
      ),
    );
  }
}
