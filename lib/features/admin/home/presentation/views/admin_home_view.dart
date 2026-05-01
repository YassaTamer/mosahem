import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/home/presentation/views/filter_view_admin.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';
import 'package:mosahem/features/organization/opportunity_details/presentation/views/opportunity_details_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key, this.adminUserName = "Betty"});
  final String adminUserName;

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  void initState() {
    super.initState();
    context.read<OpportunityCubit>().getAllOpportunities();
  }

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mustardYellow, width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 38,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/splash_logo.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),

            SizedBox(width: 10),
            AutoSizeText(
              "Hi, Moshem Admin",
              maxLines: 1,
              minFontSize: 12,
              maxFontSize: 25,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            // CustomText(
            //   "Hi, Moshem Admin.",
            //   color: AppColors.primary,
            //   fontWeight: FontWeight.bold,
            //   fontSize: 25,
            // ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: isSearching
                      ? Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            onSubmitted: (_) {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: AppColors.primary.withAlpha(
                                  (255 * 0.5).toInt(),
                                ),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Image.asset(AppAssets.searchIcon),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    isSearching = false;
                                    searchController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 280,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CustomText(
                                  "Search",
                                  fontSize: 20,
                                  color: AppColors.primary.withAlpha(
                                    (255 * 0.5).toInt(),
                                  ),
                                ),
                              ),
                              Spacer(),
                              //SizedBox(width: 190),
                              Image.asset(AppAssets.searchIcon),
                              Gap(10),
                            ],
                          ),
                        ),
                ),

                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterViewAdmin(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(AppAssets.filterIconDark),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<OpportunityCubit, OpportunityState>(
              builder: (context, state) {
                if (state is OpportunityLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is OpportunityError) {
                  return Center(child: Text(state.message));
                }

                if (state is OpportunitySuccess) {
                  final opportunities = state.opportunities;

                  if (opportunities.isEmpty) {
                    return const Center(child: Text("No opportunities found"));
                  }

                  return ListView.builder(
                    itemCount: opportunities.length,
                    itemBuilder: (context, index) {
                      final opp = opportunities[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpportunityDetailsScreen(
                                  isOrganization: true,
                                  opportunityId: opp.id,
                                ),
                              ),
                            );
                          },
                          child: PostCard(
                            orgLogo: opp.logoUrl,
                            orgName: opp.organizationName,
                            wantOrgPhoto: true,
                            applyButton: false,
                            timeAgo: opp.startDate,
                            postImage: opp.opportunityPhotoUrl ?? "",
                            title: opp.name,

                            description: opp.description ?? "No description",
                            location: opp.location ?? "Unknown",
                            status: opp.status ?? "Unknown",

                            // ✅ ضيف دول
                            workType: opp.workType ?? "Unknown",
                            timeType: opp.timeType ?? "Unknown",

                            date: opp.startDate,
                            time: opp.endDate,

                            // ✅ بدل الثابت
                            comments: (opp.commentsCount ?? 0).toString(),
                            likes: (opp.likesCount ?? 0).toString(),
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
