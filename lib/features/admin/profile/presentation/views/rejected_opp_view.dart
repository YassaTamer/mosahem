import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class RejectedOppView extends StatelessWidget {
  const RejectedOppView({
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
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.red, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
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
                  child: orgLogo.startsWith('http')
                      ? Image.network(
                          orgLogo,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Image.asset(
                            AppAssets.orgLogo,
                            width: 100,
                            height: 100,
                          ),
                        )
                      : Image.asset(
                          orgLogo,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      orgName,
                      fontSize: 20,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(oppName, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(AppAssets.startDateIcon),
                        SizedBox(width: 5),
                        CustomText(DateHelper.format(startDate), fontSize: 10),

                        SizedBox(width: 10),

                        Image.asset(AppAssets.endDateIcon),
                        SizedBox(width: 5),
                        CustomText(DateHelper.format(endDate), fontSize: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
