import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomRequiredButton extends StatefulWidget {
  final Function(bool) onChanged;
  const CustomRequiredButton({super.key, required this.onChanged});

  @override
  State<CustomRequiredButton> createState() => _CustomRequiredButtonState();
}

class _CustomRequiredButtonState extends State<CustomRequiredButton> {
  bool isRequired = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CustomText(
            "Required",
            fontSize: 20,
            color: AppColors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Switch(
          value: isRequired,
          onChanged: (value) {
            setState(() => isRequired = value);
            widget.onChanged(value);
          },
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: AppColors.white,
          activeTrackColor: AppColors.lightGreen,
        ),
      ],
    );
  }
}
