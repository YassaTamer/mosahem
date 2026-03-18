import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/add_place_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/add_questions_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/create_opp_view.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/bottom_nav_bar_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/home_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/private_org_profile_screen.dart';
import 'package:mosahem/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(AuthApiService(Dio())),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(context.read<AuthRepository>()),
          ),
        ],
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const MaterialApp(
            title: "Mosahem",
            debugShowCheckedModeBanner: false,
            home: PrivateOrgProfileScreen(),
          ),
        ),
      ),
    );
  }
}
