import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/logic/cubit/forget_password/forget_password_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';

class NewPasswordView extends StatefulWidget {
  const NewPasswordView({super.key});

  @override
  State<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends State<NewPasswordView> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
              CustomText(
                'New Password',
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
              Gap(16),
              CustomText('New Password', fontWeight: FontWeight.w600),
              Gap(4),
              CustomTextField(
                textEditingController: newPasswordController,
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
                    _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              Gap(8),
              CustomText(' Confirm Password', fontWeight: FontWeight.w600),
              Gap(4),
              CustomTextField(
                textEditingController: confirmPasswordController,
                hintText: 'Confirm your Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isConfirmPasswordHidden,

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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordResetSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
                (route) => false,
              );
            }

            if (state is ForgetPasswordError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return CustomButton(
              text: state is ForgetPasswordLoading ? "Loading..." : "Continue",
              onTap: state is ForgetPasswordLoading
                  ? null
                  : () {
                      context.read<ForgetPasswordCubit>().resetPassword(
                        newPassword: newPasswordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                      );
                    },
            );
          },
        ),
      ),
    );
  }
}
