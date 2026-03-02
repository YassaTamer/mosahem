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
    this.numberOfLines = 1,
    this.onTap,
    this.textEditingController,
    this.validator,
    this.errorText,
    this.onChange,
  });
  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? errorText;
  final Function(String)? onChange;
  final bool readonly;
  final Widget? navigatTo;
  final int? numberOfLines;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: numberOfLines,
      onChanged: onChange,
      validator: validator,
      controller: textEditingController,
      readOnly: readonly,
      onTap: () {
        if (onTap != null) {
          onTap!(); // date picker / custom logic
        } else if (navigatTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => navigatTo!),
          );
        }
      },
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      cursorWidth: 1.5,
      cursorHeight: 20,
      decoration: InputDecoration(
        errorText: errorText,
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),

        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
