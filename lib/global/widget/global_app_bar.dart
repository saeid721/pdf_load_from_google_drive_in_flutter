import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors_resources.dart';
import 'global_text.dart';


class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({
    super.key,
    required this.title,
    this.isBackIc = true,
    this.backColor,
    this.leading,
    this.notiOnTap,
    this.actions
  });
  final String title;
  final Color? backColor;
  final bool? isBackIc;
  final Widget? leading;
  final Function()? notiOnTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor ?? ColorRes.primaryColor,
      automaticallyImplyLeading: false,
      leading: leading ?? (isBackIc == true ? IconButton(
        splashRadius: 0.1,
        icon: const Icon(Icons.arrow_back, color: ColorRes.white),
        onPressed: (){
          Get.back();
        },
      ) : const SizedBox.shrink()),
      centerTitle: true,
      title: GlobalText(
        str: title,
        color: ColorRes.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.center,
      ),
      actions: actions,
    );
  }
}