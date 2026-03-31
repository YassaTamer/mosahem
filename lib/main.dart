import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/features/organization/createOpp/data/api/create_opportunity_api_service.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';
import 'package:mosahem/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/features/auth/data/api/auth_api_service.dart';
import 'package:mosahem/features/auth/data/repository/auth_repository.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';

void main() {
  runApp(MyApp(dio: DioHelper.instance.client));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(AuthApiService(dio))),
        RepositoryProvider(
          create: (_) =>
              CreateOpportunityRepository(CreateOpportunityApiService(dio)),
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
