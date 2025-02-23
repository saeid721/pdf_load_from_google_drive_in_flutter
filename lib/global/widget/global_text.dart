import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import '../constants/constant_key.dart';

class GlobalText extends StatelessWidget {
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softwrap;
  final double? height;
  final String? fontFamily;

  const GlobalText({
    super.key,
    required this.str,
    this.fontWeight,
    this.fontSize,
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.softwrap,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final h = height ?? .08;
    final fw = fontSize ?? 14;
    final double fontHeight = h * fw;
    return Text(
      str,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softwrap,
      style: TextStyle(
        color: color ?? ColorRes.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        decoration: decoration,
        height: height == null ? null : fontHeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily ?? AppConstantKey.fontFamily.key,
      ),
    );
  }
}
