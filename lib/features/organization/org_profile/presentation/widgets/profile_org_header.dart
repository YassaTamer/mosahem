import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class ProfileOrgHeader extends StatelessWidget {
  final String nameOrg;
  final String bioOrg;
  final String location;
  final int opportunities = 88;
  final int followers = 99;
  final int volunteer = 72;

  const ProfileOrgHeader({
    super.key,
    required this.nameOrg,
    required this.bioOrg,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/13013204/pexels-photo-13013204.jpeg',
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          nameOrg,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bioOrg,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.locationProfile, width: 14),
                        const SizedBox(width: 5),
                        Text(
                          location,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          /// أزرار الـ Follow و Message
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Follow",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Message",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('$opportunities', "Opportunities"),

                const VerticalDivider(
                  color: AppColors.greyLight,
                  thickness: 1,
                  width: 1,
                  indent: 5,
                  endIndent: 5,
                ),

                _buildStatItem("$followers", "Followers"),

                const VerticalDivider(
                  color: AppColors.greyLight,
                  thickness: 1,
                  width: 1,
                  indent: 5,
                  endIndent: 5,
                ),

                _buildStatItem("$volunteer", "Volunteer"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.lightGreen,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
