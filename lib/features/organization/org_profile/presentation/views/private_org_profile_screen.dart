import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/organization/org_profile/data/models/org_profile_model.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/followers_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/opportunities_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/rating_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/recent_applicants_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_header.dart';

class PrivateOrgProfileScreen extends StatefulWidget {
  final int? opportunities = 0;
  final int? followers = 0;
  final int? volunteer = 0;

  final OrgProfileModel data;

  const PrivateOrgProfileScreen({super.key, required this.data});

  @override
  State<PrivateOrgProfileScreen> createState() =>
      _PrivateOrgProfileScreenState();
}

class _PrivateOrgProfileScreenState extends State<PrivateOrgProfileScreen> {
  @override
  void initState() {
    super.initState();
    // print(widget.data.organizationId);
    // print(context.read<OrgProfileCubit>().opportunities);
    context.read<OrgProfileCubit>().getOpportunities(
      organizationId: widget.data.organizationId,
      status: 'Active',
    );
  }

  Widget statItem(String number, String title) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.lightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  String _safeValue(String? value, String fallback) {
    if (value == null || value.trim().isEmpty) {
      return fallback;
    }
    return value;
  }

  String _statusValue(String? status) {
    final normalized = (status ?? '').trim().toLowerCase();
    if (normalized == 'active') {
      return 'Open';
    }
    if (normalized.isEmpty) {
      return 'Open';
    }
    return status!.trim();
  }

  Widget _buildOpportunitiesSection() {
    final cubit = context.read<OrgProfileCubit>();
    final items = cubit.opportunitiesFor("Active");
    if (cubit.isLoadingOpportunities("Active") && items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (items.isEmpty) {
      // return const SizedBox.shrink();
      return const Center(child: Text("No Opportunities Yet"));
    }

    final locationText = widget.data.locations.isNotEmpty
        ? _safeValue(widget.data.locations.first.cityName, 'No Location')
        : 'No Location';

    return Column(
      children: items.map((OpportunityModel opportunity) {
        // print(opportunity.logoUrl);
        // print(opportunity.opportunityPhotoUrl);
        // print(widget.data.organizationLogo);
        return PostCard(
          wantOrgPhoto: true, // 🔥 أهم سطر

          orgLogo: widget.data.organizationLogo,
          orgName: _safeValue(
            opportunity.organizationName,
            widget.data.organizationName,
          ),
          timeAgo: _safeValue(opportunity.startDate, '-'),
          postImage: _safeValue(
            opportunity.opportunityPhotoUrl,
            AppAssets.postImage,
          ),
          title: _safeValue(opportunity.name, 'Opportunity'),
          description: _safeValue(widget.data.organizationDescription, '-'),
          location: locationText,
          date: _safeValue(opportunity.startDate, '-'),
          time: _safeValue(opportunity.endDate, '-'),
          comments: '0',
          likes: '0',
          status: _statusValue(opportunity.status),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: BlocBuilder<OrgProfileCubit, OrgProfileState>(
            buildWhen: (previous, current) =>
                current is OrgOpportunitiesState && current.status == "Active",
            builder: (context, _) {
              final opportunitiesCount = context
                  .read<OrgProfileCubit>()
                  .opportunitiesFor("Active")
                  .length
                  .toString();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeader(
                      logoUrl: widget.data.organizationLogo,
                      nameOrg: widget.data.organizationName,
                      bio: widget.data.organizationDescription,
                      location: widget.data.locations.isNotEmpty
                          ? widget.data.locations.first.cityName
                          : 'No Location',
                    ),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpportunitiesScreen(
                                    organizationLogo:
                                        widget.data.organizationLogo ?? "",
                                    organizationId: widget.data.organizationId,
                                  ),
                                ),
                              );
                            },
                            child: statItem(
                              opportunitiesCount,
                              "Opportunities",
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.greyLight,
                            thickness: 1,
                            width: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FollowersScreen(),
                                ),
                              );
                            },
                            child: statItem(
                              widget.followers.toString(),
                              "Followers",
                            ),
                          ),

                          VerticalDivider(
                            color: AppColors.greyLight,
                            thickness: 1,
                            width: 40,
                          ),
                          statItem(widget.volunteer.toString(), "Volunteer"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                backgroundColor: AppColors.greyLight,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Rating Voulanteer',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            _buildBadge("750"),
                          ],
                        ),

                        const SizedBox(width: 25),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecentApplicantsScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                backgroundColor: AppColors.greyLight,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Recent Applicdent',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            _buildBadge("12"),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColors.greyLight,
                      thickness: 1,
                      height: 50,
                    ),

                    _buildOpportunitiesSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildBadge(String count) {
  return Positioned(
    top: -5,
    right: -5,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Color(0xFFD4AF37),
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      child: Center(
        child: Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
