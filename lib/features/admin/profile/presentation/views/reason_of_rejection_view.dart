import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';

class ReasonOfRejectionView extends StatefulWidget {
  const ReasonOfRejectionView({super.key});

  @override
  State<ReasonOfRejectionView> createState() => _ReasonOfRejectionViewState();
}

class _ReasonOfRejectionViewState extends State<ReasonOfRejectionView> {
  bool isButtonEnabled = false;
  TextEditingController controller = TextEditingController();
  void checkIfChanged() {
    bool fieldNotEmpty = controller.text.trim().isNotEmpty;
    setState(() {
      isButtonEnabled = fieldNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Reason of Rejection',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: CustomTextField(
                  numberOfLines: 8,
                  textEditingController: controller,
                  onChange: (value) {
                    checkIfChanged();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: CustomText(
                  "(optional)",
                  color: AppColors.primary,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 280),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: CustomEnabledDisabledButton(
                  isEnabled: isButtonEnabled,
                  buttonName: "Send",
                  width: 350,
                  enabledColor: AppColors.primaryDark,
                  disabledColor: AppColors.primaryDark.withAlpha(
                    (255 * 0.5).toInt(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
