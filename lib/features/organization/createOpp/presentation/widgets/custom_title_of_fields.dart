import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomTitleOfFields extends StatelessWidget {
  const CustomTitleOfFields(
    this.text, {
    super.key,
    required this.padding,
    this.requiredMark = true,
  });
  final String text;
  final double padding;
  final bool requiredMark;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: padding),
          child: CustomText(
            text,
            color: AppColors.textDark,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (requiredMark == true) ...[
          SizedBox(width: 5),
          CustomText(
            "*",
            color: AppColors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ],
      ],
    );
  }
}
