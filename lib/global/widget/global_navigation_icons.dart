// import 'package:flutter/material.dart';
//
// class GlobalNavigationIcons extends StatelessWidget {
//   final DartBasicNavController navController;
//
//   const GlobalNavigationIcons({super.key, required this.navController});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           left: 10,
//           top: 0,
//           bottom: 0,
//           child: GestureDetector(
//             onTap: () {
//               navController.previousPage();
//             },
//             child: const Align(
//               alignment: Alignment.center,
//               child: Opacity(
//                 opacity: 0.2,
//                 child: Icon(Icons.arrow_back, size: 40, color: Colors.black),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 10,
//           top: 0,
//           bottom: 0,
//           child: GestureDetector(
//             onTap: () {
//               navController.nextPage();
//             },
//             child: const Align(
//               alignment: Alignment.center,
//               child: Opacity(
//                 opacity: 0.2,
//                 child: Icon(Icons.arrow_forward, size: 40, color: Colors.black),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }