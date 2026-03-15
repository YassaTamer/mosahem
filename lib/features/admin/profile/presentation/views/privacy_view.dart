import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/change_password_view.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/category_container_settings_widget.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Privacy',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          CategoryContainerSettings(
            text: "Change Password",
            icon: AppAssets.changePasswordIcon,
            page: ChangePasswordView(),
          ),
        ],
      ),
    );
  }
}
