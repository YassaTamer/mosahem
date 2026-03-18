import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/profile_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/rejection_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                nameOrg: 'Zad Solutions',
                bio: 'jksafljaslkfjlffkjkkkd',
                location: 'Sohag',
              ),

              const SizedBox(height: 50),
              ProfileStatst(
                text1ProfileOrg: 'Rating Voulanteer',
                text2ProfileOrg: 'Recent applicdent',
              ),
              Divider(color: AppColors.greyLight, thickness: 1, height: 30),

              const SizedBox(height: 20),
              RejectionCard(
                statusMessage: 'Reason for rejection',
                statusText:
                    "Thank you for submitting your organization for verification.\n\n",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
