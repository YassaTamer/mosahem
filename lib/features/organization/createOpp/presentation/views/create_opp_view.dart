import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/add_place_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_title_of_fields.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/image_upload_widget.dart';

class CreateOppView extends StatelessWidget {
  const CreateOppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightBlue,
        title: Center(
          child: CustomText(
            'Create Opportunity',
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: ImageUploadWidget(),
          ),
          Divider(
            thickness: 1,
            color: AppColors.primaryDark,
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(height: 10),
          CustomTitleOfFields("Title of opportunitiy", padding: 30),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: CustomTextField(),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(
                  AppAssets.addPlaceIcon,
                  height: 25,
                  width: 25,
                ),
              ),
              CustomTitleOfFields("Place", padding: 5),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: CustomTextField(
              readonly: true,
              hintText: "Select places",
              suffixIcon: Icon(Icons.add),
              navigatTo: AddPlaceView(),
            ),
          ),
        ],
      ),
    );
  }
}
