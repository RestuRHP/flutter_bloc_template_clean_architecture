import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class TextDefault extends StatelessWidget {
  final String title;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLine;
  final double? fontSize, height, letterSpacing;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;

  const TextDefault(
      this.title, {
        Key? key,
        this.fontSize,
        this.textColor,
        this.fontWeight,
        this.textAlign,
        this.maxLine,
        this.letterSpacing,
        this.height,
        this.overflow,
        this.softWrap,
        this.decoration,
        this.fontStyle,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      softWrap: softWrap,
      style: TextStyle(
        height: height,
        fontSize: fontSize ?? 14,
        color: textColor ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: decoration,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle,
      ),
    );
  }
}