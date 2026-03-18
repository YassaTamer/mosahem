import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class ProfileStatst extends StatelessWidget {
  final int opportunities = 0;
  final int followers = 0;
  final int volunteer = 0;
  final String text1ProfileOrg;
  final String text2ProfileOrg;

  const ProfileStatst({
    super.key,
    required this.text1ProfileOrg,
    required this.text2ProfileOrg,
  });

  Widget statItem(String number, String title) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.lightGreen,
            fontWeight: FontWeight.w600,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                statItem(opportunities.toString(), "Opportunities"),
                VerticalDivider(
                  color: AppColors.greyLight,
                  thickness: 1,
                  width: 40,
                ),
                statItem(followers.toString(), "Followers"),
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
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 40),
                  backgroundColor: AppColors.greyLight,
                  foregroundColor: Colors.black,
                ),

                child: Text(text1ProfileOrg, style: TextStyle(fontSize: 12)),
              ),
              SizedBox(width: 25),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(150, 40),

                  backgroundColor: AppColors.greyLight,
                  foregroundColor: Colors.black,
                ),
                child: Text(text2ProfileOrg, style: TextStyle(fontSize: 12)),
              ),
              SizedBox(height: 16),
              Divider(color: AppColors.greyLight, thickness: 1, height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
