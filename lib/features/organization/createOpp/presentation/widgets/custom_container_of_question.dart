import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.title,
    this.description,
    this.image,
    this.widthBetweenTextImage,
    this.ontap,
    this.onTapCallback, // ← أضف ده
  });
  final String? title;
  final String? description;
  final String? image;
  final double? widthBetweenTextImage;
  final Widget? ontap;
  final VoidCallback? onTapCallback; // ← أضف ده

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 3),
      child: GestureDetector(
        onTap:
            onTapCallback ?? // ← لو في callback استخدمه
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ontap!),
              );
            },
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 10),
          height: 100,
          width: 355,
          decoration: BoxDecoration(
            color: AppColors.googleButton,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title!, fontWeight: FontWeight.bold, fontSize: 15),
                  const SizedBox(height: 10),
                  CustomText(
                    description!,
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(width: widthBetweenTextImage),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image!)),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
