import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../global/constants/colors_resources.dart';
import '../../../../../../global/widget/global_text.dart';
import '../../../global/constants/enum.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_image_loader.dart';
import '../../../global/widget/global_sizedbox.dart';

class NotificationDetailsWidget extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String details;
  final String imagePath;

  const NotificationDetailsWidget({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.details,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalContainer(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            width: Get.width,
            height: 190,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: GlobalImageLoader(
                imagePath: imagePath,
                width: Get.width,
                imageFor: ImageFor.asset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_clock,
                    size: 14,
                    color: ColorRes.primaryColor,
                  ),
                  sizedBoxW(2),
                  GlobalText(
                    str: time,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              sizedBoxW(5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.date_range,
                    size: 14,
                    color: ColorRes.primaryColor,
                  ),
                  sizedBoxW(2),
                  GlobalText(
                    str: date,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.grey,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),

          sizedBoxH(10),
          GlobalText(
            str: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorRes.textColor,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          GlobalText(
            str: details,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorRes.textColor,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
