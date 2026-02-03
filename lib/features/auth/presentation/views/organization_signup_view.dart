import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
//import 'package:mosahem/features/auth/presentation/views/otp_verification_view.dart';
import 'package:mosahem/features/auth/presentation/views/upload_organization_document_view.dart';
import 'package:mosahem/features/auth/presentation/widgets/custom_phone_number_field.dart';
//hide CustomTextField;

class OrganizationSignupView extends StatefulWidget {
  const OrganizationSignupView({super.key});

  @override
  State<OrganizationSignupView> createState() => _OrganizationSignupViewState();
}

class _OrganizationSignupViewState extends State<OrganizationSignupView> {
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

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
                  CustomText(' Organization Name', fontWeight: FontWeight.w600),
                  Gap(4),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    hintText: 'Enter organization name',
                  ),
                  Gap(8),

                  CustomText(' Email', fontWeight: FontWeight.w600),
                  Gap(4),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                  ),
                  Gap(8),
                  CustomText(' Password', fontWeight: FontWeight.w600),
                  Gap(4),
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
                  CustomText(' Confirm Password', fontWeight: FontWeight.w600),
                  Gap(4),
                  CustomTextField(
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
                  Gap(8),
                  CustomText('  Phone Number', fontWeight: FontWeight.w600),
                  Gap(4),
                  CustomPhoneNumberField(countryCode: '+20'),
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UploadOrganizationDocumentView(),
              ),
            );
          },
        ),
      ),
    );
  }
}
