import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class CustomContainerRecentOpp extends StatelessWidget {
  const CustomContainerRecentOpp({
    super.key,
    required this.orgLogo,
    required this.orgName,
    required this.oppName,
    required this.startDate,
    required this.endDate,
  });

  final String orgLogo;
  final String orgName;
  final String oppName;
  final String startDate;
  final String endDate;
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
                    child: orgLogo.startsWith('http')
                        ? Image.network(
                            orgLogo,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              AppAssets.orgLogo,
                              width: 60,
                              height: 60,
                            ),
                          )
                        : Image.asset(
                            orgLogo,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      orgName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    CustomText(oppName, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(AppAssets.startDateIcon),
                        SizedBox(width: 5),
                        CustomText(startDate, fontSize: 10),

                        SizedBox(width: 10),

                        Image.asset(AppAssets.endDateIcon),
                        SizedBox(width: 5),
                        CustomText(endDate, fontSize: 10),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),
            Row(
              children: [
                CustomButton(
                  text: "Rejected",
                  color: AppColors.red,
                  width: 150,
                  height: 40,
                  onTap: () {},
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
