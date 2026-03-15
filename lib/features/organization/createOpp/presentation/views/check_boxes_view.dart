import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_dynamic_option.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_required_slide_button.dart';

class CheckBoxesView extends StatefulWidget {
  const CheckBoxesView({super.key});

  @override
  State<CheckBoxesView> createState() => _CheckBoxesViewState();
}

class _CheckBoxesViewState extends State<CheckBoxesView> {
  final TextEditingController _controller = TextEditingController();
  bool hasOptions = false;
  bool isButtonEnabled = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkIfCanSave() {
    setState(() {
      isButtonEnabled = _controller.text.trim().isNotEmpty && hasOptions;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(checkIfCanSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightBlue,
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: CustomText(
              "Check Boxes",
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 250),
            child: CustomText(
              "question",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomTextField(
              textEditingController: _controller,
              numberOfLines: 3,
              hintText: "type your question here...",
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomDynamicOption(
              isMultiSelection: true,
              onOptionsChanged: (value) {
                hasOptions = value;
                checkIfCanSave();
              },
            ),
          ),
          SizedBox(height: 5),
          CustomRequiredButton(),
          SizedBox(height: 330),
          CustomEnabledDisabledButton(
            isEnabled: isButtonEnabled,
            buttonName: "Save question",
            enabledColor: AppColors.primary,
            disabledColor: AppColors.disabledButton,
          ),
        ],
      ),
    );
  }
}
