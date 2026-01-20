import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(24),
                CustomText(
                  'Log in',
                  color: Color(0xff145D90),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                Gap(6),
                CustomText(
                  'Welcome Back!',
                  color: Color(0xff072132),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
                Gap(32),
                CustomText(
                  ' Email Or Phone Number',
                  fontWeight: FontWeight.w500,
                ),
                Gap(8),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your email or phone',
                ),
                Gap(20),
                CustomText(' Password', fontWeight: FontWeight.w500),
                Gap(8),
                CustomTextField(
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: CustomText(
                      'Forget Password',
                      color: Color(0xff145D90),
                    ),
                  ),
                ),
                Gap(110),
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
                Gap(110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText('Don’t have an account? '),
                    CustomText(
                      'Sign Up',
                      color: Color(0xff145D90),
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Gap(24),
                GestureDetector(
                  onTap: () {
                    // Login logic later
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: CustomText(
                        'Log In',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Gap(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
