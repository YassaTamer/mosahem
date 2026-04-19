import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mosahem/features/admin/home/presentation/views/admin_home_view.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/features/admin/profile/data/api/opportunities_api_service.dart';
import 'package:mosahem/features/admin/profile/data/api/organizations_api_service.dart';
import 'package:mosahem/features/admin/profile/data/api/profile_api_service.dart';
import 'package:mosahem/features/admin/profile/data/api/volunteers_api_service.dart';
import 'package:mosahem/features/admin/profile/data/repository/opportunities_repository.dart';
import 'package:mosahem/features/admin/profile/data/repository/organizations_repository.dart';
import 'package:mosahem/features/admin/profile/data/repository/profile_repository.dart';
import 'package:mosahem/features/admin/profile/data/repository/volunteers_repository.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/organization_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/profile_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/volunteer_cubit.dart';
import 'package:mosahem/features/organization/createOpp/data/api/create_opportunity_api_service.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';
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
        RepositoryProvider(
          create: (_) => VolunteersRepository(VolunteersApiService(dio)),
        ),
        RepositoryProvider(
          create: (_) => OpportunitiesRepository(
            OpportunitiesApiService(DioHelper.instance.client),
          ),
        ),
        RepositoryProvider(
          create: (_) => OrganizationsRepository(OrganizationsApiService(dio)),
        ),
        RepositoryProvider(
          create: (_) => ProfileRepository(ProfileApiService(dio)),
        ),
        RepositoryProvider(create: (_) => AuthRepository(AuthApiService(dio))),
        RepositoryProvider(
          create: (_) =>
              CreateOpportunityRepository(CreateOpportunityApiService(dio)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                VolunteerCubit(context.read<VolunteersRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                OpportunityCubit(context.read<OpportunitiesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                OrganizationCubit(context.read<OrganizationsRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ProfileCubit(context.read<ProfileRepository>()),
          ),
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
            debugShowCheckedModeBanner: false,
            home: AdminHomeView(),
          ),
        ),
      ),
    );
  }
}
