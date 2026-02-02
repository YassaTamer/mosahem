import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class LabeledFieldRow extends StatelessWidget {
  const LabeledFieldRow({
    super.key,
    required this.label,
    required this.hint,
    required this.isRequired,
  });
  final String label;
  final String hint;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              CustomText(label, fontSize: 14, fontWeight: FontWeight.w500),
              if (isRequired) const CustomText(' *', color: Colors.red),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primaryDark),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomText(
                    hint,
                    fontSize: 13,
                    color: Colors.grey.shade800,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryDark),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
