// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'widget/colors.dart';
// import 'custom_drawer_screen.dart';
//
// class SideBerMenuWidget extends StatelessWidget {
//   const SideBerMenuWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           SizedBox(
//             height: 170,
//             child: DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: ColorRes.primaryColor,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/placeholder_image.png',
//                     width: 220,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/capital.png',
//             title: "Capital",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/profit.png',
//             title: "Profit",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/invest.png',
//             title: "Invest",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/expense.png',
//             title: "Expense",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/charity.png',
//             title: "Charity",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/gallery.png',
//             title: "Gallery",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/news.png',
//             title: "News",
//             onTap: () {
//               Get.to(() => ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/event.png',
//             title: "Event",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/notice.png',
//             title: "Notice",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/about.png',
//             title: "About Us",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ChapterItem(
//             leadingImage: 'assets/icons/contact.png',
//             title: "Contact Us",
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//           ListTile(
//             title: const Text('Home'),
//             onTap: () {
//               Get.to(() => const ());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }