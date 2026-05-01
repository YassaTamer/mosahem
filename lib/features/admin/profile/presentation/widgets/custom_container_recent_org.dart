import 'package:auto_size_text/auto_size_text.dart';
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
    required this.onAccept,
    required this.onReject,
  });
  final String orgLogo;
  final String orgName;
  final String date;
  final VoidCallback onAccept;
  final VoidCallback onReject;
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
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppAssets.orgLogo,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            orgLogo,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  // 🔥 مهم جدًا
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        orgName,
                        maxLines: 1,
                        minFontSize: 12,
                        maxFontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      CustomText(date, fontSize: 12),
                    ],
                  ),
                ),

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
                    onReject();
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
                  onTap: onAccept,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
