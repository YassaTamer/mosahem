import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_constant.dart';
import 'package:mosahem/core/constants/user_role.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
import 'package:mosahem/features/layout/presentation/views/main_layout_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    if (isDevMode) {
      debugPrint('DEV_MODE is enabled. Session persistence is still active.');
    }

    final hasValidSession = await CacheHelper.hasValidSession();
    if (!mounted) return;

    if (!hasValidSession) {
      await CacheHelper.clearSession();
      if (!mounted) return;
      _goToLogin();
      return;
    }

    final role = await CacheHelper.getRole();
    if (!mounted) return;

    if (role == null || role.isEmpty) {
      await CacheHelper.clearSession();
      if (!mounted) return;
      _goToLogin();
      return;
    }

    try {
      _goToHome(parseUserRole(role));
    } catch (_) {
      await CacheHelper.clearSession();
      if (!mounted) return;
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
      (route) => false,
    );
  }

  void _goToHome(UserRole role) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainLayoutView(role: role)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.splashLogo),
            Gap(12),
            CustomText(
              'مُساهم',
              fontSize: 32,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
