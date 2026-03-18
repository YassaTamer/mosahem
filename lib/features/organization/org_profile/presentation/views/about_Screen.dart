import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/org_profile_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/about_description.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/location_section_about.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/save_bottom.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/tracks_section_about.dart';

class AboutScreen extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  const AboutScreen({super.key, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrgProfileScreen()),
            );
            print("Sending data to API...");
          },
          bottomText: 'Save edit',
        ),
      ),
    );
  }
}
