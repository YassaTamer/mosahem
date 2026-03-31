import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';

class AddNewAdminView extends StatefulWidget {
  const AddNewAdminView({super.key});

  @override
  State<AddNewAdminView> createState() => _AddNewAdminViewState();
}

class _AddNewAdminViewState extends State<AddNewAdminView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  bool _isConfirmPasswordHidden = true;
  bool _isPasswordHidden = true;
  bool isButtonEnabled = false;
  String? passwordError;
  String? confirmPasswordError;
  String? phoneNumberError;
  String? emailError;
  void validatePasswords() {
    setState(() {
      // *** Validation of Password ***
      if (passwordController.text.isEmpty) {
        passwordError = null;
      } else if (passwordController.text.length < 6) {
        passwordError = "Password must be more than 6 characters";
      } else if (!RegExp(r'[0-9]').hasMatch(passwordController.text)) {
        passwordError = "Password must contain at least one number";
      } else if (!RegExp(r'[A-Z]').hasMatch(passwordController.text)) {
        passwordError = "Password must contain a capital letter";
      } else if (!RegExp(r'[!@#\$&*~]').hasMatch(passwordController.text)) {
        passwordError = "Password must contain a special character";
      } else {
        passwordError = null;
      }

      // *** Validation of Confirm Password ***
      if (confirmPasswordController.text.isEmpty) {
        confirmPasswordError = null;
      } else if (confirmPasswordController.text != passwordController.text) {
        confirmPasswordError = "Passwords do not match";
      } else {
        confirmPasswordError = null;
      }
    });
  }

  //*** Validation Phone Number ***
  void validatePhoneNumber() {
    setState(() {
      if (phoneController.text.isEmpty) {
        phoneNumberError = null;
      } else if (phoneController.text.length < 11 ||
          phoneController.text.length > 11) {
        phoneNumberError = "phone number must be 11 number";
      } else {
        phoneNumberError = null;
      }
    });
  }

  //*** Validation Email ***
  void validateEmail() {
    setState(() {
      if (emailController.text.isEmpty) {
        emailError = null;
      } else if (!RegExp(r'@').hasMatch(emailController.text)) {
        emailError = "email must contain @";
      } else if (!RegExp(".com").hasMatch(emailController.text)) {
        emailError = "email must contain .com extension";
      } else {
        emailError = null;
      }
    });
  }

  void checkIfChanged() {
    bool fieldNotEmpty =
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        fullNameController.text.trim().isNotEmpty;
    setState(() {
      isButtonEnabled =
          fieldNotEmpty &&
          passwordError == null &&
          confirmPasswordError == null &&
          phoneNumberError == null &&
          emailError == null;
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
              //*** Title of the page ***
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
                child: CustomText(
                  "Add New Admin",
                  color: AppColors.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: CustomText(
                  "Please enter the new admin details to grant access.",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),

              //*** Email field ***
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Email",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: emailController,
                  hintText: "Enter Admin's Email...",
                  keyboardType: TextInputType.emailAddress,
                  errorText: emailError,
                  onChange: (value) {
                    validateEmail();
                    checkIfChanged();
                  },
                ),
              ),

              //*** Phone number field ***
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Phone number",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: phoneController,
                  hintText: "Enter Admin's number...",
                  errorText: phoneNumberError,
                  keyboardType: TextInputType.numberWithOptions(),
                  onChange: (value) {
                    validatePhoneNumber();
                    checkIfChanged();
                  },
                ),
              ),

              //*** Full Name field ***
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Full Name",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: fullNameController,
                  hintText: "Enter Admin's Full Name...",
                  onChange: (value) {
                    checkIfChanged();
                  },
                ),
              ),

              //*** Password field ***
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 5),
                child: CustomText(
                  "Password",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextField(
                  textEditingController: passwordController,
                  hintText: "Enter Admin's Password...",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isPasswordHidden,
                  errorText: passwordError,
                  onChange: (value) {
                    validatePasswords();
                    checkIfChanged();
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
              ),

              //*** Confirm Password field ***
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
                  hintText: "Confirm new password",
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
              SizedBox(height: 50),

              //*** Save Button ***
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomEnabledDisabledButton(
                  isEnabled: isButtonEnabled,
                  buttonName: "Save",
                  enabledColor: AppColors.lightGreen,
                  disabledColor: AppColors.lightGreen.withAlpha(
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
