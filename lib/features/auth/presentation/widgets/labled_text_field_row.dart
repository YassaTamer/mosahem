import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class LabeledTextFieldRow extends StatelessWidget {
  const LabeledTextFieldRow({
    super.key,
    required this.label,
    required this.hint,
    required this.isRequired,
    this.height = 40, this.controller,
  });

  final String label;
  final String hint;
  final bool isRequired;
  final double height;
final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label
        Row(
          children: [
            CustomText(label, fontSize: 14, fontWeight: FontWeight.w500),
            if (isRequired) const CustomText(' *', color: Colors.red),
          ],
        ),

        // Field
        Expanded(
          flex: 6,
          child: Container(
            
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.primaryDark),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller:controller ,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
