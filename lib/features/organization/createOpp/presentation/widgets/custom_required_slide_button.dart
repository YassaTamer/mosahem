import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomRequiredButton extends StatefulWidget {
  const CustomRequiredButton({super.key});

  @override
  State<CustomRequiredButton> createState() => _CustomRequiredButtonState();
}

class _CustomRequiredButtonState extends State<CustomRequiredButton> {
  bool isrequired = false;
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
        SizedBox(width: 5),
        Switch(
          value: isrequired,
          onChanged: (value) {
            setState(() {
              isrequired = value;
            });
          },
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: AppColors.white,
          activeTrackColor: AppColors.lightGreen,
        ),
      ],
    );
  }
}
