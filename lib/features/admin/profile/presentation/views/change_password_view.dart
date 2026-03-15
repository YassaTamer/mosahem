import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  bool _isOldPasswordHidden = true;
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  bool isButtonEnabled = false;
  String? newPasswordError;
  bool newPasswordErrorBool = false;
  String? confirmPasswordError;
  bool confirmPasswordErrorBool = false;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  void validatePasswords() {
    setState(() {
      if (oldPasswordController.text == newPasswordController.text &&
          newPasswordController.text.isNotEmpty) {
        newPasswordError = "New password must be different from old password";
        newPasswordErrorBool = true;
      } else {
        newPasswordError = null;
        newPasswordErrorBool = false;
      }

      if (confirmPasswordController.text != newPasswordController.text &&
          confirmPasswordController.text.isNotEmpty) {
        confirmPasswordError = "Passwords do not match";
        confirmPasswordErrorBool = true;
      } else {
        confirmPasswordError = null;
        confirmPasswordErrorBool = false;
      }
      if (newPasswordController.text.length < 6) {
        newPasswordError = "Password must be more than 6 characters";
        newPasswordErrorBool = true;
      } else if (!RegExp(r'[0-9]').hasMatch(newPasswordController.text)) {
        newPasswordError = "Password must contain at least one number";
        newPasswordErrorBool = true;
      } else if (!RegExp(r'[A-Z]').hasMatch(newPasswordController.text)) {
        newPasswordError = "Password must contain a capital letter";
        newPasswordErrorBool = true;
      } else if (!RegExp(r'[!@#\$&*~]').hasMatch(newPasswordController.text)) {
        newPasswordError = "Password must contain a special character";
        newPasswordErrorBool = true;
      } else {
        newPasswordError = null;
        newPasswordErrorBool = false;
      }
    });
  }

  void checkIfChanged() {
    bool fieldNotEmpty =
        oldPasswordController.text.trim().isNotEmpty &&
        newPasswordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;
    setState(() {
      isButtonEnabled =
          fieldNotEmpty &&
          newPasswordErrorBool == false &&
          confirmPasswordErrorBool == false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                child: CustomText(
                  "Change Password",
                  color: AppColors.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: CustomText(
                  "The password must be different than before",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Old Password",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: oldPasswordController,
                  hintText: "Enter your old Password...",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isOldPasswordHidden,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isOldPasswordHidden = !_isOldPasswordHidden;
                      });
                    },
                    icon: Icon(
                      _isOldPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "New Password",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: newPasswordController,
                  hintText: 'Enter your new Password...',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isNewPasswordHidden,
                  errorText: newPasswordError,
                  onChange: (value) {
                    validatePasswords();
                    checkIfChanged();
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isNewPasswordHidden = !_isNewPasswordHidden;
                      });
                    },
                    icon: Icon(
                      _isNewPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Confirm Password",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: confirmPasswordController,
                  hintText: 'Confirm new Password...',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isConfirmPasswordHidden,
                  errorText: confirmPasswordError,
                  onChange: (value) {
                    validatePasswords();
                    checkIfChanged();
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                      });
                    },
                    icon: Icon(
                      _isConfirmPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              CustomEnabledDisabledButton(
                isEnabled: isButtonEnabled,
                buttonName: "Save",
                enabledColor: AppColors.lightGreen,
                disabledColor: AppColors.lightGreen.withAlpha(
                  (255 * 0.5).toInt(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
