import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/edit_profile_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/recent_opportunities_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/recent_organizations_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/settings_and_activity_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/total_opportunities_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/total_organizations_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/total_volunteers_view.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/category_container_profile.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/profile_clipper_widget.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Mosahem',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileView()),
              );
            },
            icon: Image.asset(AppAssets.editProfileIcon, width: 24, height: 24),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsAndActivityView(),
                ),
              );
            },
            icon: Image.asset(AppAssets.settingsIcon, width: 24, height: 24),
          ),
        ],
      ),

      body: ListView(
        children: [
          //*** Container of admin info ***
          Align(
            alignment: AlignmentDirectional.topStart,
            child: SizedBox(
              width: 320,
              height: 130,
              child: ClipPath(
                clipper: ProfileClipper(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(color: AppColors.primary),
                  child: Row(
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
                            child: Image.asset(
                              "assets/images/splash_logo.png",
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "Betty Bassem",
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset(AppAssets.phoneIcon),
                                SizedBox(width: 10),
                                CustomText(
                                  "01225256162",
                                  color: AppColors.white,
                                  fontSize: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //*** Divider ***
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: AppColors.primaryDark,
            endIndent: 10,
            indent: 10,
          ),

          //*** Organizations container ***
          CategoryContainerProfile(
            containerName: "Organizations",
            containerNumber: 800,
            totalButtonName: "total organizations",
            recentButtonName: "recent organizations",
            containerImage: AppAssets.organizationIcon2,
            leftPaddingImage: 4,
            navigationTotalPage: TotalOrganizationsView(),
            navigationRecentPage: RecentOrganizationsView(),
          ),

          SizedBox(height: 10),

          //*** Opportunity container ***
          CategoryContainerProfile(
            containerName: "Opportunities",
            containerNumber: 105,
            totalButtonName: "total opportunities",
            recentButtonName: "recent opportunities",
            containerImage: AppAssets.opportunityIcon,
            navigationTotalPage: TotalOpportunitiesView(),
            navigationRecentPage: RecentOpportunitiesView(),
          ),

          SizedBox(height: 10),

          //*** Volunteer container ***
          CategoryContainerProfile(
            containerName: "Volunteers",
            containerNumber: 1000,
            totalButtonName: "total volunteers",
            recentButton: false,
            containerImage: AppAssets.volunteerIcon2,
            leftPaddingImage: 95,
            navigationTotalPage: TotalVolunteersView(),
            recentPage: false,
          ),
        ],
      ),
    );
  }
}
