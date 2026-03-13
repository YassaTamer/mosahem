import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Edit Profile',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      body: Column(
        children: [
          //*** Name Container ***
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryDark, width: 1),
              ),
              child: Row(
                children: [
                  CustomText("Name: ", fontSize: 15),
                  SizedBox(width: 105),
                  CustomText(
                    "Betty Bassem",
                    color: AppColors.textGrey,
                    fontSize: 15,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppAssets.editRightArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //*** Phone number container ***
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryDark, width: 1),
              ),
              child: Row(
                children: [
                  CustomText("Phone number:", fontSize: 15),
                  SizedBox(width: 41),
                  CustomText(
                    "01225256162",
                    color: AppColors.textGrey,
                    fontSize: 15,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      AppAssets.editRightArrow,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
