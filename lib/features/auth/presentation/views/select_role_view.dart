import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/presentation/views/organization_signup_view.dart';
import 'package:mosahem/features/auth/presentation/views/volunteer_signup_view.dart';
import 'package:mosahem/features/auth/presentation/widgets/role_card.dart';

class SelectRoleView extends StatelessWidget {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.07, // 6% من العرض
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: screenHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.05),

                        SvgPicture.asset(
                          AppAssets.splashLogo,
                          height: screenHeight * 0.12,
                        ),

                        SizedBox(height: screenHeight * 0.02),

                        CustomText(
                          'مُساهم',
                          fontSize: screenWidth * 0.08, // responsive font
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold,
                        ),

                        SizedBox(height: screenHeight * 0.08),

                        RoleCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OrganizationSignupView(),
                              ),
                            );
                          },
                          text: 'Organization',
                          iconPath: AppAssets.organizationIcon,
                        ),

                        SizedBox(height: screenHeight * 0.03),

                        RoleCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const VolunteerSignupView(),
                              ),
                            );
                          },
                          text: 'Volunteer',
                          iconPath: AppAssets.volunteerIcon,
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
