import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/app_snackbar.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';
import 'package:mosahem/features/auth/logic/cubit/forget_password/forget_password_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/forget_password_view.dart';
import 'package:mosahem/features/auth/presentation/views/select_role_view.dart';
import 'package:mosahem/features/layout/presentation/views/main_layout_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              duration: const Duration(seconds: 2),
              content: const AppSnackBar(
                message: 'تم تسجيل الدخول بنجاح',
                color: Colors.green,
                icon: Icons.check_circle_rounded,
              ),
            ),
          );

          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MainLayoutView(role: state.role),
              ),
            );
          });
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 0),

              duration: const Duration(seconds: 3),

              content: AppSnackBar(message: state.message),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(12),
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
                      textEditingController: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter your email or phone',
                    ),
                    Gap(20),
                    CustomText(' Password', fontWeight: FontWeight.w500),
                    Gap(8),
                    CustomTextField(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (context) => ForgetPasswordCubit(
                                  context.read<AuthRepository>(),
                                ),
                                child: ForgetPasswordView(),
                              ),
                            ),
                          );
                        },
                        child: CustomText(
                          'Forget Password',
                          color: AppColors.primary,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText('Don’t have an account?'),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SelectRoleView()),
                      );
                    },
                    child: const CustomText(
                      'Sign Up',
                      color: Color(0xff145D90),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    text: 'Log In',
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      context.read<AuthCubit>().login(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
