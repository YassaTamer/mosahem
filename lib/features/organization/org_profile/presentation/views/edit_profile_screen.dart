import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/photo_section.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          children: [
            SizedBox(height: 150),

            PhotoSection(),

            SizedBox(height: 95),

            ProfileForm(),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
