import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class AcceptedOppView extends StatefulWidget {
  const AcceptedOppView({
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
  State<AcceptedOppView> createState() => _AcceptedOppViewState();
}

class _AcceptedOppViewState extends State<AcceptedOppView> {
  bool resume = false;

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
                    child: widget.orgLogo.startsWith('http')
                        ? Image.network(
                            widget.orgLogo,
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
                            widget.orgLogo,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      widget.orgName,
                      fontSize: 20,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(widget.oppName, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(AppAssets.startDateIcon),
                        SizedBox(width: 5),
                        CustomText(
                          DateHelper.format(widget.startDate),
                          fontSize: 10,
                        ),

                        SizedBox(width: 10),

                        Image.asset(AppAssets.endDateIcon),
                        SizedBox(width: 5),
                        CustomText(
                          DateHelper.format(widget.endDate),
                          fontSize: 10,
                        ),
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
                  text: resume == false ? "Stop" : "Resume",
                  color: resume == false ? AppColors.red : AppColors.lightGreen,
                  width: 317,
                  height: 40,
                  onTap: () {
                    setState(() {
                      resume = !resume;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
