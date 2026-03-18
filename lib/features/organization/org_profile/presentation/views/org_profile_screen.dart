import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_org_content.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_org_header.dart';

class OrgProfileScreen extends StatelessWidget {
  const OrgProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            /// الجزء الأول (الهيدر)
            const ProfileOrgHeader(
              nameOrg: 'mario Nabil',
              bioOrg: 'mario Nabil',
              location: 'Sohag',
            ),

            /// الجزء التاني (التابات + البوستات)
            const Expanded(child: ProfileOrgContent()),
          ],
        ),
      ),
    );
  }
}
