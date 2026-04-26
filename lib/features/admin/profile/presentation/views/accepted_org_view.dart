import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class AcceptedOrgView extends StatelessWidget {
  const AcceptedOrgView({
    super.key,
    required this.orgLogo,
    required this.orgName,
    required this.onDelete,
  });
  final String orgLogo;
  final String orgName;
  final VoidCallback onDelete;
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
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 34,
              child: ClipOval(
                child: Image.asset(orgLogo, width: 80, height: 80),
              ),
            ),
            SizedBox(width: 10),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       CustomText(
            //         orgName,
            //         fontSize: 20,
            //         color: AppColors.primary,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    orgName,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            //     const Spacer(),

            //*** Delete Button ***
            CustomButton(
              text: "Delete",
              fontSize: 15,
              fontColor: AppColors.white,
              width: 80,
              height: 40,
              color: AppColors.red,
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
