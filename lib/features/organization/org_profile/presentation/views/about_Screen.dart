import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/about_description.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/location_section_about.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/save_bottom.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/tracks_section_about.dart';

class AboutScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
 // final OrgProfileModel data;

  const AboutScreen({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const AboutDescriptionSection(
              description: "Mosahem is a volunteering platform...",
              vision: "We believe that everyone has the ability...",
            ),
            const Divider(height: 40),

            const LocationsSection(),
            const Divider(height: 40),

            const TracksSection(),

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: SaveButton(
          onTap: () {
            Navigator.pop(
              context,
              // MaterialPageRoute(
              //   builder: (context) => PrivateOrgProfileScreen(data: data,),
              // ),
            );
            //print("Sending data to API...");
          },
          bottomText: 'Save edit',
        ),
      ),
    );
  }
}
