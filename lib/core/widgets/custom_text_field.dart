import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.readonly = false,
    this.navigatTo,
    this.numberOfLines,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool readonly;
  final Widget? navigatTo;
  final int? numberOfLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: numberOfLines,
      onTap: navigatTo == null
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => navigatTo!),
              );
            },
      readOnly: readonly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      cursorWidth: 1.5,
      cursorHeight: 20,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
