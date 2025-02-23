import 'package:flutter/material.dart';
import '../../../global/constants/colors_resources.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sizedbox.dart';
import '../../../global/widget/global_text.dart';

class SocialMediaWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String imagePath;
  final String text;
  const SocialMediaWidget({
    super.key,
    this.height,
    this.width,
    this.maxLines,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ColorRes.white,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: ColorRes.borderColor, width: .2),
        boxShadow: [
          BoxShadow(
            color: ColorRes.grey.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 5),
            child: GlobalImageLoader(
              imagePath: imagePath,
              height: height ?? 40,
              width: width ?? 40,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 5),
          GlobalText(
            str: text,
            color: ColorRes.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: maxLines ?? 1,
          ),
        ],
      ),
    );
  }
}
