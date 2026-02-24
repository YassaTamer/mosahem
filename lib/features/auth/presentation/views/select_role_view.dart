import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/organization_signup_view.dart';
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
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              children: [
                SvgPicture.asset(AppAssets.splashLogo),
                CustomText(
                  'مُساهم',
                  fontSize: 32,
                  fontFamily: 'Tajawal',
                  fontWeight: FontWeight.bold,
                ),
                Gap(32),
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
                Gap(32),
                RoleCard(
                  onTap: () {},
                  text: 'Volunteer',
                  iconPath: AppAssets.volunteerIcon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
