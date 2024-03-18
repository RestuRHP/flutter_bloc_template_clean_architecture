import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers extends StatelessWidget {
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  const Shimmers({
    Key? key,
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColors.lavenderGray,
        ),
      ),
    );
  }
}
