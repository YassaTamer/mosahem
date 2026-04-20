import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class AboutDescriptionSection extends StatelessWidget {
  final String description;
  final String vision;

  const AboutDescriptionSection({
    super.key,
    required this.description,
    required this.vision,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Mosahem",
          style: TextStyle(
            color: AppColors.lightGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(description),
        const SizedBox(height: 20),
        Text(
          "Our Vision",
          style: TextStyle(
            color: AppColors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(vision),
      ],
    );
  }
}
