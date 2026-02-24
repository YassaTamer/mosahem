import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/logic/cubit/forget_password/forget_password_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
import 'package:mosahem/features/auth/presentation/views/new_password_view.dart';

class ForgotOtpVerificationView extends StatefulWidget {
  const ForgotOtpVerificationView({super.key});

  @override
  State<ForgotOtpVerificationView> createState() =>
      _ForgotOtpVerificationViewState();
}

class _ForgotOtpVerificationViewState extends State<ForgotOtpVerificationView> {
  String getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(String value, int index) {
    final cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // ===== PASTE =====
    if (cleanValue.length > 1) {
      final chars = cleanValue.split('');

      for (int i = 0; i < chars.length && index + i < 6; i++) {
        _controllers[index + i].text = chars[i];
      }

      if (index + chars.length < 6) {
        _focusNodes[index + chars.length].requestFocus();
      } else {
        _focusNodes[5].unfocus();
      }
      return;
    }

    // ===== DELETE =====
    if (cleanValue.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
      return;
    }

    // ===== NORMAL INPUT =====
    if (index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordOtpVerified) {
          final cubit = context.read<ForgetPasswordCubit>();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: const NewPasswordView(),
              ),
            ),
          );
        }
        if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Verification',
                  color: Color(0xff145D90),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                Gap(4),
                CustomText(
                  'Enter the 6-digit OTP code that we send to',
                  color: AppColors.textGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  context.read<ForgetPasswordCubit>().email ?? '',
                  color: AppColors.primaryDark,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                Gap(64),
                Center(
                  child: Column(
                    children: [CustomText('Enter OTP', fontSize: 24)],
                  ),
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    final boxWidth =
                        (MediaQuery.of(context).size.width - 80) / 6;

                    return SizedBox(
                      height: 56,
                      width: boxWidth,
                      child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],

                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.primaryDark,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.primaryDark,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          onOtpChanged(value, index);
                        },
                      ),
                    );
                  }),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText('Didn\'t receive the OTP code? '),
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
                        'Resend',
                        color: Color(0xff145D90),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),

          child: CustomButton(
            text: 'Verify Now',
            onTap: () {
              print("BUTTON PRESSED");
              final code = getOtpCode();

              print("CODE = $code");

              if (code.length != 6) {
                print("INVALID LENGTH");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter full OTP")),
                );
                return;
              }

              print("CALLING CUBIT");
              context.read<ForgetPasswordCubit>().verifyOtp(code: code);
            },
          ),
        ),
      ),
    );
  }
}
