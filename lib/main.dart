import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/createOpp/data/api/create_opportunity_api_service.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';
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
        RepositoryProvider(
          create: (_) =>
              CreateOpportunityRepository(CreateOpportunityApiService(Dio())),
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
            home: SplashView(),
          ),
        ),
      ),
    );
  }
}
