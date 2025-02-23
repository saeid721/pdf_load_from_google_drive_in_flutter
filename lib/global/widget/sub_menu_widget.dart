import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';
import '../../global/widget/global_sizedbox.dart';

class SubMenuWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final int? maxLines;
  final String text;
  const SubMenuWidget({
    super.key,
    this.height,
    this.width,
    this.maxLines,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context).width,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorRes.grey.withOpacity(0.2), // Border color
          width: 1.0,         // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: ColorRes.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ColorRes.primaryColor,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: ColorRes.primaryColor,
            size: 16,
          ),
        ],
      ),
    );
  }
}
