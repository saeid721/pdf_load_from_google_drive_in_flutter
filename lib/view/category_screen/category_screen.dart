import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/constants/images.dart';
import '../../global/widget/global_app_bar.dart';
import '../../global/widget/global_container.dart';
import '../../model/model.dart';
import '../custom_drawer_screen.dart';
import '../general_books_screen/general_books_list_screen.dart';
import 'components/category_menu_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

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

  int currentIndex = 0;
  final CarouselController buttonCarouselController = CarouselController();

  final List<String> sliderImage = [
    'assets/images/1.jpg',
    'assets/images/2.png',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: GlobalAppBar(
          title: 'Dart & Flutter Tutorial',
          notiOnTap: () {},
          leading: GestureDetector(
            onTap: () {
              if (drawerKey.currentState!.isDrawerOpen) {
                drawerKey.currentState!.closeDrawer();
              } else {
                drawerKey.currentState!.openDrawer();
              }
            },
            child: const Icon(Icons.menu, color: ColorRes.white),
          ),
        ),
      ),
      key: drawerKey,
      drawer: const CustomDrawerScreen(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 1:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 2:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 3:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 4:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 5:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 6:
                            Get.to(() => const GeneralBooksListScreen());
                            break;
                          case 7:
                            Get.to(() => const GeneralBooksListScreen());
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
    );
  }
}
