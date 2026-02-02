import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomPhoneNumberField extends StatelessWidget {
  const CustomPhoneNumberField({
    super.key,
    this.hintText = '01091966271',
    this.countryCode = '+20',
    this.onCountryTap,
    this.controller,
  });

  final String hintText;
  final String countryCode;
  final VoidCallback? onCountryTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryDark, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onCountryTap,
            child: Row(
              children: [
                CustomText(countryCode, fontWeight: FontWeight.w600),
                const Gap(4),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),

          const Gap(8),

          Container(width: 1, height: 28, color: Colors.grey),

          const Gap(12),

          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              cursorColor: AppColors.primary,
              cursorWidth: 1.3,
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
