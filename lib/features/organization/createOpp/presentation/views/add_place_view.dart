import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_title_of_fields.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/drop_down_list.dart';

class AddPlaceView extends StatefulWidget {
  const AddPlaceView({super.key});

  @override
  State<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends State<AddPlaceView> {
  TextEditingController descriptionController = TextEditingController();
  String? selectedGovernment;
  String? selectedCity;
  final governmentKey = GlobalKey();
  final cityKey = GlobalKey();
  bool get isSaveEnabled => selectedGovernment != null && selectedCity != null;
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
                //*** Government Section ***
                Row(
                  children: [
                    CustomTitleOfFields("Government:", padding: 0),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropDownList(
                        key: governmentKey,
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
                        onChanged: (value) {
                          setState(() {
                            selectedGovernment = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                //*** City Section ***
                Row(
                  children: [
                    CustomTitleOfFields("City:", padding: 0),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropDownList(
                        key: cityKey,
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
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                //*** Description Section ***
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
                  textEditingController: descriptionController,
                  hintText: "Enter addtional details about this branch...",
                  numberOfLines: 4,
                ),
                SizedBox(height: 10),

                //*** Buttons Section ***
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 53),
                      child: CustomButton(
                        text: "Cancel",
                        color: AppColors.red,
                        height: 40,
                        width: 100,
                        onTap: () {
                          setState(() {
                            selectedCity = null;
                            selectedGovernment = null;
                            descriptionController.clear();
                          });
                          (governmentKey.currentState as dynamic)?.reset();
                          (cityKey.currentState as dynamic)?.reset();
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    CustomEnabledDisabledButton(
                      isEnabled: isSaveEnabled,
                      buttonName: "Save Location",
                      enabledColor: AppColors.lightGreen,
                      disabledColor: AppColors.lightGreen.withAlpha(
                        (255 * 0.5).toInt(),
                      ),
                      width: 155,
                      height: 50,
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
