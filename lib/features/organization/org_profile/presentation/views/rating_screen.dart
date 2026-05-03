import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/helpers/app_snackbar_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/unrated_volunteer_model.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/search_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/rationg_card.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrgProfileCubit>().getUnratedVolunteers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: BlocBuilder<OrgProfileCubit, OrgProfileState>(
          builder: (context, state) {
            final count = context
                .read<OrgProfileCubit>()
                .unratedVolunteers
                .length;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Rating Volunteer",
                  style: TextStyle(
                    color: Color(0xFF1B5E78),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search, color: Colors.grey),
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
          final items = cubit.unratedVolunteers;

          if (cubit.isLoadingUnrated && items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrgUnratedVolunteersError) {
            return Center(child: Text(state.message));
          }

          if (items.isEmpty) {
            return const Center(child: Text("No volunteers to rate"));
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
            itemBuilder: (context, index) {
              final UnratedVolunteerModel v = items[index];
              return RatingCard(
                name: v.fullName,
                bio: v.bio ?? "No bio",
                imageUrl: v.profileImage ?? "",
                rating: 0,
                onRatingChanged: (rating) {},
                onSubmit: (rating) {
                  // أخفي الشخص من الليست
                  setState(() {
                    cubit.unratedVolunteers.removeAt(index);
                  });
                  // ورّي الـ snackbar
                  AppSnackBarHelper.success(
                    context,
                    "${v.fullName} rated $rating stars",
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
