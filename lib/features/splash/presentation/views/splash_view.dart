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
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    final token = await CacheHelper.getToken();
    if (isDevMode) {
      _goToLogin();
      return;
    }
    if (token != null && token.isNotEmpty) {
      _goToHome();
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

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AdminHomeView()),
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
