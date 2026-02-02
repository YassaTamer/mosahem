import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.height,
    this.fontSize,
    this.width, this.color,
  });
  final String text;
  final VoidCallback? onTap;
  final double? height;
  final double? fontSize;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 55,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryDark,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: CustomText(
            text,
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
