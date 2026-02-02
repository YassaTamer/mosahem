import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/presentation/views/select_tracks_view.dart';
import 'package:mosahem/features/auth/presentation/widgets/labeled_field_row.dart';
import 'package:mosahem/features/auth/presentation/widgets/labled_text_field_row.dart';

class AddBranchLocationView extends StatelessWidget {
  const AddBranchLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(AppAssets.splashLogo, width: 36),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Add Branch Location',
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                Gap(6),
                CustomText(
                  'Please enter the details of your Branch Location.',
                  color: Color(0xff072132),
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                Gap(6),
                Divider(color: AppColors.greyLight, thickness: 1.2),
                Gap(6),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.locationIcon, width: 24),
                    Gap(12),
                    CustomText(
                      'Location',
                      color: AppColors.primaryDark,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Gap(6),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryDark,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabeledFieldRow(
                        label: 'Governorate:',
                        hint: 'Select Governorate ',
                        isRequired: true,
                      ),
                      Gap(6),
                      LabeledFieldRow(
                        label: 'City:',
                        hint: 'Select City ',
                        isRequired: true,
                      ),
                      Gap(6),
                      LabeledTextFieldRow(
                        label: 'Branch Address:',
                        hint: 'enter full address',
                        isRequired: true,
                      ),
                      Gap(6),
                      Column(
                        children: [
                          Row(
                            children: [
                              CustomText(
                                'Description ',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                '(Optional)',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                          Gap(6),
                          Container(
                            height: 85,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.primaryDark),
                            ),
                            child: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    'Enter additional details about this branch...',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(6),
                      Row(
                        children: [
                          Gap(12),

                          Expanded(
                            child: CustomButton(
                              text: 'Cancel',
                              height: 32,
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                          Gap(6),
                          Expanded(
                            child: CustomButton(
                              fontSize: 12,
                              color: Colors.green,
                              text: 'Save Location',
                              height: 32,
                            ),
                          ),
                          Gap(12),
                        ],
                      ),
                    ],
                  ),
                ),
                Gap(6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD8B50C)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                            CustomText(
                              'Nasr City ',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                            CustomText(
                              'Abbas El Akkad Street',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                            CustomText(
                              'Near the Boys’ Preparatory School',
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // ⭐ مهم
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.delete, color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectTracksView()),
                );
              },
              child: const CustomText(
                'Skip',
                color: Color(0xffD8B50C),
                fontSize: 18,
              ),
            ),
            const Gap(12),
            Expanded(
              child: CustomButton(
                text: 'Continue',
                color: AppColors.primaryDark,

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SelectTracksView()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
