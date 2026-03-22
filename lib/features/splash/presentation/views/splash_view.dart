import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_constant.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/presentation/views/admin_home_view.dart';
import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';
import 'package:mosahem/features/auth/presentation/views/login_view.dart';
import 'package:mosahem/features/organization/presentation/views/organization_home_view.dart';

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

    final token = await CacheHelper.getToken();
    final role = await CacheHelper.getRole();

    if (isDevMode) {
      _goToLogin();
      return;
    }

    if (token != null && token.isNotEmpty && role != null) {
      _goToHome(role);
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => AuthCubit(AuthRepository(AuthApiService(Dio()))),
          child: const LoginView(),
        ),
      ),
    );
  }

  void _goToHome(String role) {
    Widget page;

    switch (role.toLowerCase()) {
      case 'admin':
        page = const AdminHomeView();
        break;

      case 'organization':
        page = const OrganizationHomeView();
        break;

      case 'volunteer':
        page = const OrganizationHomeView();
        break;

      default:
        page = const LoginView();
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
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
