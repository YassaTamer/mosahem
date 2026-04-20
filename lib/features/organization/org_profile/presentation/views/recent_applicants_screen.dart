import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/views/search_screen.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/applicant_card.dart';

class RecentApplicantsScreen extends StatelessWidget {
  final String title = "Recent applicant";

  const RecentApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),

      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        itemCount: 12,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xFFF0F0F0),
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          return ApplicantCard(
            applicantName: "Wade Warren",
            onReject: () {
           //   print("Rejected user $index");
            },
            onAccept: () {
              print("Accepted user $index");
            },
          );
        },
      ),
    );
  }
}
