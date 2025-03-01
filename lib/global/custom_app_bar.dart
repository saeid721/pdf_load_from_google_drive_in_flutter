import 'package:flutter/material.dart';
import '../../global/constants/colors_resources.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;
  final Color iconColor;
  final double elevation;
  final Color shadowColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor = Colors.white,
    this.iconColor = ColorRes.primaryColor,
    this.elevation = 1.0,
    this.shadowColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      shadowColor: shadowColor,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      centerTitle: centerTitle,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ColorRes.primaryColor,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
