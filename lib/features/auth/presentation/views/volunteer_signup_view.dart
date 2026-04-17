import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
import 'package:mosahem/features/auth/presentation/views/otp_verification_view.dart';
import 'package:mosahem/core/widgets/custom_phone_number_field.dart';

class VolunteerSignupView extends StatefulWidget {
  const VolunteerSignupView({super.key});

  @override
  State<VolunteerSignupView> createState() => _VolunteerSignupViewState();
}

class _VolunteerSignupViewState extends State<VolunteerSignupView> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? selectedGender;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? fullNameError;
  String? phoneError;
  String? nationalIdError;
  String? dateOfBirthError;
  String? genderError;
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthOtpSent) {
          Navigator.pop(context); // يقفل اللودينج

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  OtpVerificationView(email: emailController.text.trim()),
            ),
          );
        }

        if (state is AuthError) {
          Navigator.pop(context); // يقفل اللودينج

          setState(() {
            fullNameError = state.fieldErrors?["FullName"];
            emailError = state.fieldErrors?["Email"];

            passwordError = state.fieldErrors?["Password"];

            confirmPasswordError = state.fieldErrors?["ConfirmPassword"];

            phoneError = state.fieldErrors?["PhoneNumber"];
            nationalIdError = state.fieldErrors?["NationalId"];
            dateOfBirthError = state.fieldErrors?["DateOfBirth"];
            genderError = state.fieldErrors?["Gender"];
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 32),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(4),
                    CustomText(
                      'Sign Up',
                      color: Color(0xff145D90),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(4),
                    CustomText(
                      'New Account!',
                      color: Color(0xff072132),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    Gap(8),
                    CustomText('Full Name', fontWeight: FontWeight.w600),
                    Gap(4),
                    CustomTextField(
                      errorText: fullNameError,

                      textEditingController: nameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Enter name',
                    ),
                    CustomText(' National ID', fontWeight: FontWeight.w600),
                    Gap(4),
                    CustomTextField(
                      errorText: nationalIdError,
                      textEditingController: nationalIdController,
                      hintText: 'Enter your national ID',
                    ),
                    Gap(8),
                    CustomText(' Date Of Birth', fontWeight: FontWeight.w600),
                    Gap(4),
                    // CustomTextField(
                    //   errorText: dateOfBirthError,
                    //   textEditingController: dateController,
                    //   hintText: 'YYYY-MM-DD',
                    // ),
                    CustomTextField(
                      errorText: dateOfBirthError,
                      textEditingController: dateController,
                      hintText: 'Select your birth date',
                      //   readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;

                            dateController.text = DateHelper.format(
                              pickedDate.toIso8601String(),
                            );

                            dateOfBirthError = null;
                          });
                        }
                      },
                    ),
                    Gap(8),
                    CustomText(' Gender', fontWeight: FontWeight.w600),
                    Gap(4),

                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      hint: const Text('Select Gender'),

                      decoration: InputDecoration(
                        errorText: genderError,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryDark),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primaryDark),
                        ),
                      ),

                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                          genderError = null;
                        });
                      },
                    ),
                    Gap(8),
                    Gap(8),
                    CustomText(' Email', fontWeight: FontWeight.w600),
                    Gap(4),
                    CustomTextField(
                      errorText: emailError,
                      onChange: (_) {
                        if (emailError != null) {
                          setState(() {
                            emailError = null;
                          });
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      textEditingController: emailController,
                    ),
                    Gap(8),
                    CustomText(' Password', fontWeight: FontWeight.w600),
                    Gap(4),
                    CustomTextField(
                      onChange: (_) {
                        if (passwordError != null) {
                          setState(() {
                            passwordError = null;
                          });
                        }
                      },
                      errorText: passwordError,
                      textEditingController: passwordController,

                      hintText: 'Enter your Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isPasswordHidden,
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
                    Gap(8),
                    CustomText(
                      ' Confirm Password',
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(4),
                    CustomTextField(
                      onChange: (_) {
                        if (confirmPasswordError != null) {
                          setState(() {
                            confirmPasswordError = null;
                          });
                        }
                      },
                      errorText: confirmPasswordError,

                      textEditingController: confirmPasswordController,

                      hintText: 'Confirm your Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _isConfirmPasswordHidden,

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordHidden =
                                !_isConfirmPasswordHidden;
                          });
                        },
                        icon: Icon(
                          _isConfirmPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    Gap(8),
                    CustomText('  Phone Number', fontWeight: FontWeight.w600),
                    Gap(4),
                    CustomPhoneNumberField(
                      errorText: phoneError,
                      controller: phoneController,
                      countryCode: '+20',
                    ),
                    Gap(24),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // to login with google
                          //
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xffB6CDDD),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset('assets/logos/google_logo.svg'),
                              Gap(16),
                              CustomText('Continue With Gmail', fontSize: 16),
                              Gap(16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gap(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText('Already have an account? '),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginView()),
                            );
                          },
                          child: const CustomText(
                            'Log In',
                            color: Color(0xff145D90),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: CustomButton(
            text: 'Continue',
            onTap: () {
              if (selectedGender == null) {
                setState(() {
                  genderError = "Please select gender";
                });
                return;
              }

              if (selectedDate == null) {
                setState(() {
                  dateOfBirthError = "Please select date";
                });
                return;
              }

              int genderValue = selectedGender == "Male" ? 1 : 2;

              context.read<AuthCubit>().validateVolunteerBasicInfo(
                fullName: nameController.text.trim(),
                email: emailController.text.trim(),
                phoneNumber: phoneController.text.trim(),
                password: passwordController.text.trim(),
                confirmPassword: confirmPasswordController.text.trim(),
                dateOfBirth: selectedDate!.toIso8601String(),
                gender: genderValue,
                nationalId: nationalIdController.text.trim(),
              );
            },
          ),
        ),
      ),
    );
  }
}
