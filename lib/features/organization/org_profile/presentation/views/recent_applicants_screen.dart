import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/admin/profile/data/models/volunteer_model.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/applicant_card.dart';

class RecentApplicantsScreen extends StatefulWidget {
  const RecentApplicantsScreen({super.key});

  @override
  State<RecentApplicantsScreen> createState() => _RecentApplicantsScreenState();
}

class _RecentApplicantsScreenState extends State<RecentApplicantsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrgProfileCubit>().getVolunteers("pending");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Recent Applicants",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: Colors.grey, size: 26),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => SearchScreen()),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: BlocBuilder<OrgProfileCubit, OrgProfileState>(
        builder: (context, state) {
          final cubit = context.read<OrgProfileCubit>();
          final items = cubit.volunteersFor("pending");

          if (cubit.isLoadingVolunteers("pending") && items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrgVolunteersError) {
            return Center(child: Text(state.message));
          }

          if (items.isEmpty) {
            return const Center(child: Text("No Applicants Yet"));
          }

          return ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              color: Color(0xFFF0F0F0),
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              final VolunteerModel v = items[index];
              return ApplicantCard(
                applicantName: v.name,
                userImageUrl: v.image ?? "",
                jobTitle: v.bio ?? "No bio",
                dateText: "${v.age} years • ${v.totalHours} hrs",
                onReject: () {
                  setState(() {
                    cubit.volunteersMap["pending"]?.removeAt(index);
                  });
                },
                onAccept: () {
                  setState(() {
                    cubit.volunteersMap["pending"]?.removeAt(index);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
