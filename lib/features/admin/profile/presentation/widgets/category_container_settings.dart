import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CategoryContainerSettings extends StatelessWidget {
  const CategoryContainerSettings({
    super.key,
    required this.text,
    required this.icon,
    required this.page,
  });
  final String text;
  final String icon;
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.primaryLightBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Image.asset(icon),
              SizedBox(width: 10),
              CustomText(
                text,
                color: text == "Log out" ? AppColors.red : AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
