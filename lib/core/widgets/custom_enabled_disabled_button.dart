import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomEnabledDisabledButton extends StatefulWidget {
  const CustomEnabledDisabledButton({
    super.key,
    required this.isEnabled,
    required this.buttonName,
    required this.enabledColor,
    required this.disabledColor,
    this.width = 300,
    this.height = 50,
    this.onTap,
  });
  final VoidCallback? onTap;
  final bool isEnabled;
  final String buttonName;
  final Color enabledColor;
  final Color disabledColor;
  final double width;
  final double height;

  @override
  State<CustomEnabledDisabledButton> createState() =>
      _CustomEnabledDisabledButtonState();
}

class _CustomEnabledDisabledButtonState
    extends State<CustomEnabledDisabledButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: widget.isEnabled ? widget.onTap : null,
        style:
            ElevatedButton.styleFrom(
              fixedSize: Size(widget.width, widget.height),
              backgroundColor: widget.enabledColor,
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return widget.disabledColor;
                }
                return widget.enabledColor;
              }),
            ),
        child: CustomText(
          widget.buttonName,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
