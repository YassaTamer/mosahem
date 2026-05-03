import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/follower_card.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrgProfileCubit>().getVolunteers("accepted");
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
                .volunteersFor("accepted")
                .length;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Volunteers",
                  style: TextStyle(
                    color: AppColors.primary,
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
          final items = cubit.volunteersFor("accepted");

          if (cubit.isLoadingVolunteers("accepted") && items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrgVolunteersError) {
            return Center(child: Text(state.message));
          }

          if (items.isEmpty) {
            return const Center(child: Text("No Volunteers Yet"));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final v = items[index];
              return FollowerCard(
                name: v.name,
                bio: v.bio ?? "No bio",
                imageUrl: v.image ?? "",
                onDelete: () {
                  setState(() {
                    cubit.volunteersMap["accepted"]?.removeAt(index);
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
