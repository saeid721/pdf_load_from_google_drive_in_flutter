import 'package:flutter/material.dart';

import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../../global/widget/global_text.dart';

class CategoryMenuWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String imagePath;
  final String text;
  final String subText;
  const CategoryMenuWidget({
    super.key,
    this.height,
    this.width,
    this.maxLines,
    required this.imagePath,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: ColorRes.white,
        boxShadow: [
          BoxShadow(
            color: ColorRes.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: GlobalImageLoader(
              imagePath: imagePath,
              height: height ?? 40,
              width: width ?? 40,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GlobalText(
                  str: text,
                  color: ColorRes.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: maxLines ?? 1,
                ),
              ),
              // const SizedBox(width: 5),
              // GlobalText(
              //   str: subText,
              //   color: ColorRes.black,
              //   fontSize: 10,
              //   fontWeight: FontWeight.w400,
              //   overflow: TextOverflow.ellipsis,
              //   textAlign: TextAlign.center,
              //   maxLines: maxLines ?? 1,
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
