import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/admin/profile/presentation/views/setting_view.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/views/profile_edit_screen.dart';

class SettingScreenVol extends StatelessWidget {
  const SettingScreenVol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Setting & Activity',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade100, height: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildSettingItem(
              icon: Icons.settings_outlined,
              title: 'Setting',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                  (route) => route.isFirst,
                );
              },
            ),
            const SizedBox(height: 16),

            _buildSettingItem(
              icon: Icons.lock_outline,
              title: 'Privacy',
              onTap: () {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                //   (route) => false,
                // );
              },
            ),
            const SizedBox(height: 16),

            _buildSettingItem(
              icon: Icons.logout_outlined,
              title: 'Log out',
              isLogout: true,
              onTap: () async {
                await CacheHelper.clearSession();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                  (route) => route.isFirst,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2F8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.lightGreen, size: 24),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: isLogout ? Colors.red : AppColors.primaryDark,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
