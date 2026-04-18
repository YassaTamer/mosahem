import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/followers_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/opportunities_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/rating_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/recent_applicants_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/opportunities_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_org_header.dart';

class PrivateOrgProfileScreen extends StatelessWidget {
  final int? opportunities = 0;
  final int? followers = 0;
  final int? volunteer = 0;

  const PrivateOrgProfileScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileHeader(nameOrg: 'dsf', bio: 'fgdss', location: 'sohag'),

                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OpportunitiesScreen(),
                            ),
                          );
                        },
                        child: statItem(
                          opportunities.toString(),
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
                        child: statItem(followers.toString(), "Followers"),
                      ),

                      VerticalDivider(
                        color: AppColors.greyLight,
                        thickness: 1,
                        width: 40,
                      ),
                      statItem(volunteer.toString(), "Volunteer"),
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
                                builder: (context) => RecentApplicantsScreen(),
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
                Divider(color: AppColors.greyLight, thickness: 1, height: 50),

                PostCard(
                  orgName: 'mario',
                  timeAgo: '10/10/1000',
                  postImage: AppAssets.postImage,
                  title: 'kajhfkajhfasf',
                  description: 'asfdasfasf',
                  location: 'sohag',
                  date: '10',
                  time: '10',
                  comments: '3',
                  likes: '0',
                ),
              ],
            ),
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
