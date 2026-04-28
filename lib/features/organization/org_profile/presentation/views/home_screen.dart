import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/private_org_profile_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/pending_card.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/rejection_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrgProfileCubit>().getMyOrganization();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgProfileCubit, OrgProfileState>(
      buildWhen: (previous, current) {
        return current is OrgProfileInitial ||
            current is OrgProfileLoading ||
            current is OrgProfileApproved ||
            current is OrgProfilePending ||
            current is OrgProfileRejected ||
            current is OrgProfileError;
      },
      builder: (context, state) {
        final data = state is OrgProfileDataState ? state.data : null;

        /// ?? Loading
        if (state is OrgProfileLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// ? Approved ? ??? ?????????
        if (state is OrgProfileApproved) {
          return PrivateOrgProfileScreen(data: state.data);
        }

        /// ? ???? ??????? ? ???? HomeScreen UI
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (data != null)
                    ProfileHeader(
                      logoUrl: data.organizationLogo,
                      nameOrg: data.organizationName,
                      bio: data.organizationDescription,
                      location: data.locations.isNotEmpty
                          ? data.locations.first.cityName
                          : 'No Location',
                    ),
                  Divider(color: AppColors.greyLight, thickness: 1, height: 30),

                  /// ? ?? Rejected ? ???? ?????
                  if (state is OrgProfileRejected)
                    RejectionCard(
                      statusMessage: "Rejected",
                      statusText: state.reason ?? "No reason provided",
                    ),

                  /// ? ?? Pending ? ?????
                  if (state is OrgProfilePending) const PendingCard(),
                  //    const SizedBox(height: 20),
                  // ProfileStatst(
                  //   text1ProfileOrg: 'Rating Voulanteer',
                  //   text2ProfileOrg: 'Recent applicdent',
                  // ),
                  //   Divider(color: AppColors.greyLight, thickness: 1, height: 30),
                  const SizedBox(height: 20),
                  // RejectionCard(
                  //   statusMessage: 'Reason for rejection',
                  //   statusText:
                  //       "Thank you for submitting your organization for verification.\n\n",
                  // ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// الاسكرين اللي هتظهر لو ريجيكتد
