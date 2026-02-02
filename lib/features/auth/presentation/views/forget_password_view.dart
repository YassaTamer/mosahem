import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/presentation/views/otp_verification_view.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(12),
              CustomText(
                'Forget Password',
                color: Color(0xff145D90),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              Gap(6),
              CustomText(
                'Enter your email account to reset password',
                color: Color(0xff072132),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(56),
              CustomText(' Email Or Phone Number', fontWeight: FontWeight.w500),
              Gap(8),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Enter your email or phone',
              ),
              Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),

        child: CustomButton(
          text: 'Continue',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OtpVerificationView()),
            );
          },
        ),
      ),
    );
  }
}
