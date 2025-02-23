import 'package:flutter/material.dart';
import '../../../../../../global/constants/colors_resources.dart';
import '../../../../../../global/widget/global_text.dart';
import '../../../global/widget/global_container.dart';
import '../../../global/widget/global_sizedbox.dart';

class NotificationWidget extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String details;

  final Function() onTap;
  const NotificationWidget({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.details,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlobalContainer(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        margin: const EdgeInsets.only(bottom: 15, top: 5, right: 5),
        borderRadiusCircular: 10,
        borderColor: ColorRes.primaryColor,
        borderWidth: .3,
        elevation: 3,
        child: Column(
          children: [
            GlobalText(
              str: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorRes.textColor,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
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
            GlobalText(
              str: details,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorRes.textColor,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
