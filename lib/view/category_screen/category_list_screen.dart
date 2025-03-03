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
    GlobalMenuModel(img: Images.appLogo, text: 'Dart Basic'),
    GlobalMenuModel(img: Images.appLogo, text: 'Dart OOP'),
    GlobalMenuModel(img: Images.appLogo, text: 'Advance Topics'),
    GlobalMenuModel(img: Images.appLogo, text: 'Dart Quiz'),
    GlobalMenuModel(img: Images.appLogo, text: 'Flutter Basics'),
    GlobalMenuModel(img: Images.appLogo, text: 'Flutter Advanced'),
    GlobalMenuModel(img: Images.appLogo, text: 'Flutter Quiz'),
    GlobalMenuModel(img: Images.appLogo, text: 'Interview Questions'),
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
