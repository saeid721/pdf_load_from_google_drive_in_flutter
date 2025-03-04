import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_viewer/view/url_pdf_screen.dart';
import '../../../controller/pdf_controller.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/custom_bottom_navbar.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../data/general_books_list.dart';
import '../../global/constants/images.dart';
import '../../global/custom_app_bar.dart';
import '../../global/widget/global_progress_hub.dart';
import '../../model/model.dart';
import '../download/components/download_model.dart';
import 'components/category_list_widget.dart';
import 'components/category_menu_widget.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen>
    with SingleTickerProviderStateMixin {

  List<GlobalMenuModel> menuItem = [
    GlobalMenuModel(img: Images.appLogo, text: 'English Books'),
    GlobalMenuModel(img: Images.appLogo, text: 'অনুবাদ বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'বাংলাদেশ ও মুক্তিযুদ্ধ বিষয়ক'),
    GlobalMenuModel(img: Images.appLogo, text: 'ইসলামিক বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'ইতিহাস ও সংস্কৃতি'),
    GlobalMenuModel(img: Images.appLogo, text: 'আত্মউন্নয়নমূলক বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'আত্মজীবনী ও স্মৃতিকথা'),
    GlobalMenuModel(img: Images.appLogo, text: 'গণিত, বিজ্ঞান ও প্রযুক্তি'),
    GlobalMenuModel(img: Images.appLogo, text: 'সায়েন্স ফিকশন / বৈজ্ঞানিক কল্পকাহিনী'),
    GlobalMenuModel(img: Images.appLogo, text: 'থ্রিলার রহস্য রোমাঞ্চ অ্যাডভেঞ্চার'),
    GlobalMenuModel(img: Images.appLogo, text: 'গোয়েন্দা (ডিটেকটিভ)'),
    GlobalMenuModel(img: Images.appLogo, text: 'উপন্যাস'),
    GlobalMenuModel(img: Images.appLogo, text: 'কাব্যগ্রন্থ / কবিতা'),
    GlobalMenuModel(img: Images.appLogo, text: 'কিশোর সাহিত্য'),
    GlobalMenuModel(img: Images.appLogo, text: 'গল্পগ্রন্থ / গল্পের বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'ধর্ম ও দর্শন'),
    GlobalMenuModel(img: Images.appLogo, text: 'ধর্মীয় বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'প্রবন্ধ ও গবেষণা'),
    GlobalMenuModel(img: Images.appLogo, text: 'ভৌতিক, হরর, ভূতের বই'),
    GlobalMenuModel(img: Images.appLogo, text: 'ভ্রমণ কাহিনী'),
    GlobalMenuModel(img: Images.appLogo, text: 'সাহিত্য ও ভাষা'),
    GlobalMenuModel(img: Images.appLogo, text: 'রচনাসমগ্র / রচনাবলী / রচনা সংকলন'),
  ];

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
                  spacing: 5,
                  children: [
                    GridView.builder(
                        itemCount: menuItem.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 110),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 1:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 2:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 3:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 4:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 5:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 6:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                                case 7:
                                  Get.to(() => const CategoryListScreen());
                                  break;
                              }
                            },
                            child: CategoryMenuWidget(
                              height: 50,
                              width: 50,
                              maxLines: 1,
                              imagePath: menuItem[index].img,
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
        ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      );
    });
  }
}
