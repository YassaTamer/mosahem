import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';
import 'package:mosahem/features/organization/opportunity_details/presentation/views/opportunity_details_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/logic/volunteer_profile_cubit.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/logic/volunteer_profile_state.dart';

class VolunteerHomeView extends StatefulWidget {
  const VolunteerHomeView({super.key, this.adminUserName = "Betty"});
  final String adminUserName;

  @override
  State<VolunteerHomeView> createState() => _VolunteerHomeViewState();
}

class _VolunteerHomeViewState extends State<VolunteerHomeView> {
  @override
  void initState() {
    super.initState();
    context.read<OpportunityCubit>().getAllOpportunities();
    _loadProfile(); // ← أضف ده
  }

  Future<void> _loadProfile() async {
    final userId = await CacheHelper.getUserId();
    if (userId != null && mounted) {
      context.read<VolunteerProfileCubit>().getVolunteerProfile(userId);
    }
  }

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List _cachedOpportunities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: BlocBuilder<VolunteerProfileCubit, VolunteerProfileState>(
          builder: (context, state) {
            final profile = state is VolunteerProfileSuccess
                ? state.profile
                : null;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.mustardYellow,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 38,
                    child: ClipOval(
                      child: profile?.profilePhoto != null
                          ? Image.network(
                              profile!.profilePhoto!,
                              width: 76,
                              height: 76,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.person, size: 38),
                            )
                          : const Icon(Icons.person, size: 38),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CustomText(
                  profile != null
                      ? "Hi, ${profile.name.split(' ').first}..."
                      : "Hi...",
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ],
            );
          },
        ),
      ),

      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             isSearching = true;
          //           });
          //         },
          //         child: isSearching
          //             ? Container(
          //                 width: 280,
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   color: AppColors.primaryLightBlue,
          //                   borderRadius: BorderRadius.circular(16),
          //                 ),
          //                 child: TextField(
          //                   controller: searchController,
          //                   autofocus: true,
          //                   onSubmitted: (_) {
          //                     setState(() {
          //                       isSearching = false;
          //                     });
          //                   },
          //                   decoration: InputDecoration(
          //                     hintText: "Search",
          //                     hintStyle: TextStyle(
          //                       color: AppColors.primary.withAlpha(
          //                         (255 * 0.5).toInt(),
          //                       ),
          //                     ),
          //                     border: InputBorder.none,
          //                     prefixIcon: Image.asset(AppAssets.searchIcon),
          //                     suffixIcon: IconButton(
          //                       icon: Icon(Icons.close),
          //                       onPressed: () {
          //                         setState(() {
          //                           isSearching = false;
          //                           searchController.clear();
          //                         });
          //                       },
          //                     ),
          //                   ),
          //                 ),
          //               )
          //             : Container(
          //                 width: 280,
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   color: AppColors.primaryLightBlue,
          //                   borderRadius: BorderRadius.circular(16),
          //                 ),
          //                 child: Row(
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.only(left: 10),
          //                       child: CustomText(
          //                         "Search",
          //                         fontSize: 20,
          //                         color: AppColors.primary.withAlpha(
          //                           (255 * 0.5).toInt(),
          //                         ),
          //                       ),
          //                     ),
          //                     SizedBox(width: 170),
          //                     Image.asset(AppAssets.searchIcon),
          //                   ],
          //                 ),
          //               ),
          //       ),
          //       SizedBox(width: 10),
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => FilterViewVolunteer(),
          //             ),
          //           );
          //         },
          //         child: Container(
          //           height: 50,
          //           width: 50,
          //           decoration: BoxDecoration(
          //             color: AppColors.primaryLightBlue,
          //             borderRadius: BorderRadius.circular(16),
          //           ),
          //           child: Image.asset(AppAssets.filterIconDark),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<OpportunityCubit, OpportunityState>(
              builder: (context, state) {
                if (state is OpportunityLoading) {
                  // لو عندنا cache، وريه بدل اللودينج
                  if (_cachedOpportunities.isNotEmpty) {
                    // اكمل للأسفل وورّي الـ cache
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }

                if (state is OpportunityError && _cachedOpportunities.isEmpty) {
                  return Center(child: Text(state.message));
                }

                if (state is OpportunitySuccess) {
                  _cachedOpportunities = state.opportunities;
                }

                // ← هنا بيشوف الـ cache دايماً بغض النظر عن الـ state
                if (_cachedOpportunities.isEmpty) {
                  return const Center(child: Text("No opportunities found"));
                }

                return ListView.builder(
                  itemCount: _cachedOpportunities.length,
                  itemBuilder: (context, index) {
                    final opp = _cachedOpportunities[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpportunityDetailsScreen(
                                isOrganization: false,
                                opportunityId: opp.id,
                              ),
                            ),
                          );
                        },
                        child: PostCard(
                          orgLogo: opp.logoUrl,
                          orgName: opp.organizationName,
                          wantOrgPhoto: true,
                          applyButton: true,
                          timeAgo: opp.startDate,
                          postImage: opp.opportunityPhotoUrl ?? "",
                          title: opp.name,
                          description: opp.description ?? "No description",
                          location: opp.location ?? "Unknown",
                          status: opp.status ?? "Unknown",
                          workType: opp.workType ?? "Unknown",
                          timeType: opp.timeType ?? "Unknown",
                          date: opp.startDate,
                          time: opp.endDate,
                          comments: (opp.commentsCount ?? 0).toString(),
                          likes: (opp.likesCount ?? 0).toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
