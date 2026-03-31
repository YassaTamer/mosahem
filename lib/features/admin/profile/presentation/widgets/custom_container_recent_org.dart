import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/reason_of_rejection_view.dart';

class CustomContainerRecentOrg extends StatelessWidget {
  const CustomContainerRecentOrg({
    super.key,
    required this.orgLogo,
    required this.orgName,
    required this.date,
  });
  final String orgLogo;
  final String orgName;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.googleButton.withAlpha((255 * 0.5).toInt()),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: 34,
                  child: ClipOval(
                    child: Image.asset(orgLogo, width: 100, height: 100),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      orgName,
                      fontSize: 20,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(date, fontSize: 12),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(AppAssets.documentationIcon),
                ),
              ],
            ),

            SizedBox(height: 12),
            Row(
              children: [
                CustomButton(
                  text: "Rejected",
                  color: AppColors.red,
                  width: 150,
                  height: 40,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReasonOfRejectionView(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                CustomButton(
                  text: "Accepted",
                  color: AppColors.lightGreen,
                  width: 150,
                  height: 40,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
