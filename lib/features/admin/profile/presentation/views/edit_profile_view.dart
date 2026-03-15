import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/editable_text_field.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController(
    text: "Betty Bassem",
  );
  TextEditingController phoneController = TextEditingController(
    text: "01225256162",
  );
  String originalName = "Betty Bassem";
  String originalPhone = "01225256162";
  bool isButtonEnabled = false;
  void checkIfChanged() {
    bool nameChanged = nameController.text.trim() != originalName;
    bool phoneChanged = phoneController.text.trim() != originalPhone;

    bool fieldsNotEmpty =
        nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty;

    setState(() {
      isButtonEnabled = (nameChanged || phoneChanged) && fieldsNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(checkIfChanged);
    phoneController.addListener(checkIfChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Edit Profile',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      body: ListView(
        children: [
          //*** Name field ***
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: EditableTextField(
              label: "Name:",
              controller: nameController,
            ),
          ),

          //*** Phone number field ***
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: EditableTextField(
              label: "Phone number:",
              controller: phoneController,
            ),
          ),
          SizedBox(height: 420),

          //*** Save edit button ***
          CustomEnabledDisabledButton(
            isEnabled: isButtonEnabled,
            buttonName: "Save Edit",
            enabledColor: AppColors.lightGreen,
            disabledColor: AppColors.lightGreen.withAlpha((255 * 0.5).toInt()),
          ),
        ],
      ),
    );
  }
}
