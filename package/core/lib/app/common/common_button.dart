import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class CommonButton extends StatelessWidget {
  final double? width, height, fontSize, borderRadius, paddingBottom;
  final Widget? title;
  final String? font;
  final Color? backgroundColor, textColor, borderColor;
  final FontWeight? fontWeight;
  final Function()? onPressed;
  final TextAlign? textAlign;
  final bool? isBottomButton;
  final EdgeInsetsGeometry? margin;

  const CommonButton({
    Key? key,
    this.textAlign,
    this.width,
    this.height,
    this.title,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.fontWeight,
    this.font,
    this.fontSize,
    this.borderRadius,
    this.isBottomButton,
    this.paddingBottom,
    this.margin,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: isBottomButton == false,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppColors.grey,
            splashFactory: NoSplash.splashFactory,
            backgroundColor: backgroundColor ?? AppColors.black,
            shadowColor: Colors.transparent,
            minimumSize: Size(width ?? double.infinity, height ?? 40),
            shape: RoundedRectangleBorder(
              side: borderColor == null
                  ? BorderSide.none
                  : BorderSide(
                color: borderColor!,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: title,
          ),
        ),
      ),
    );
  }
}