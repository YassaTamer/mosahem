import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_title_of_fields.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/drop_down_list.dart';

class AddPlaceView extends StatelessWidget {
  const AddPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightBlue,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Image.asset(AppAssets.addPlaceIcon),
            ),
            CustomText(
              'Add Place',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Image.asset(
                    AppAssets.locationIcon2,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CustomText(
                  "New place",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3, vertical: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomTitleOfFields("Government:", padding: 0),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropDownList(
                        options: [
                          'Cairo',
                          'Alexandria',
                          'Port Said',
                          'Suez',
                          'New Valley',
                          'Luxor',
                          'Giza',
                          'Beheira',
                          'Aswan',
                          'Asyut',
                          'Sohag',
                          'Beni Suef',
                          'Dakahlia',
                          'Damietta',
                          'Faiyum',
                          'Gharbia',
                          'Ismailia',
                          'Kafr El Sheikh',
                          'Matrouh',
                          'Minya',
                          'Monufia',
                          'North sinai',
                        ],
                        labeltext: "Select Government",
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CustomTitleOfFields("City:", padding: 0),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropDownList(
                        options: [
                          "Nasr City",
                          "New Cairo",
                          "Heliopolis",
                          "Maadi",
                          "Zamalek",
                          "Downtown Cairo",
                        ],
                        labeltext: "Select City",
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CustomTitleOfFields("Branch Address:", padding: 0),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 50,
                      width: 163,
                      child: CustomTextField(
                        hintText: "Enter full address",
                        numberOfLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CustomText(
                      "Description",
                      color: AppColors.textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "(Optional)",
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                CustomTextField(
                  hintText: "Enter addtional details about this branch...",
                  numberOfLines: 4,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 73),
                      child: CustomButton(
                        text: "Cancel",
                        color: AppColors.red,
                        height: 40,
                        width: 100,
                      ),
                    ),
                    SizedBox(width: 5),
                    CustomButton(
                      text: "Save Location",
                      color: AppColors.lightGreen,
                      height: 40,
                      width: 140,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
