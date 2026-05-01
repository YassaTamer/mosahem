import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/admin_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/privacy_view.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/category_container_settings.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';

class SettingsAndActivityView extends StatelessWidget {
  const SettingsAndActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Settings & Activity',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          // CategoryContainerSettings(
          //   text: "Setting",
          //   icon: AppAssets.settingIcon,
          //   page: SettingView(),
          // ),
          CategoryContainerSettings(
            text: "Privacy",
            icon: AppAssets.privacyIcon,
            page: PrivacyView(),
          ),
          CategoryContainerSettings(
            text: "Admin",
            icon: AppAssets.adminIcon,
            page: AdminView(),
          ),
          CategoryContainerSettings(
            text: "Log out",
            icon: AppAssets.logoutIcon,
            page: Container(), // مش هيتستخدم
            onTap: () async {
              await CacheHelper.clearSession();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
