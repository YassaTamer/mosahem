import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/edit_profile_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/settings_screen.dart';

class ProfileHeader extends StatelessWidget {
  final String nameOrg;
  final String bio;
  final String location; 
  // final OrgProfileModel data;


  const ProfileHeader({
    super.key,
    required this.nameOrg,
    required this.bio,
    required this.location, //required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 38,
            backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/13013204/pexels-photo-13013204.jpeg',
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameOrg,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 4),

                Text(bio, style: TextStyle(fontSize: 12, color: Colors.black)),

                SizedBox(height: 6),

                Row(
                  children: [
                    SvgPicture.asset(AppAssets.locationProfile),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(fontSize: 12, color: AppColors.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                icon: SvgPicture.asset(AppAssets.editPen),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                icon: Icon(Icons.more_vert, color: AppColors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
