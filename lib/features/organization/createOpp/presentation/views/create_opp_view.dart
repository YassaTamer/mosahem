import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/add_place_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/add_questions_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_title_of_fields.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/drop_down_list.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/image_upload_widget.dart';

class CreateOppView extends StatefulWidget {
  const CreateOppView({super.key});

  @override
  State<CreateOppView> createState() => _CreateOppViewState();
}

class _CreateOppViewState extends State<CreateOppView> {
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  @override
  void dispose() {
    startDateController.dispose();
    super.dispose();
  }

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
          //*** Image Upload Section ***
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: ImageUploadWidget(),
          ),

          //*** Line divider ***
          Divider(
            thickness: 1,
            color: AppColors.primaryDark,
            endIndent: 20,
            indent: 20,
          ),
          SizedBox(height: 10),

          //*** Title of opportunity section ***
          CustomTitleOfFields("Title of opportunitiy", padding: 20),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CustomTextField(),
          ),
          SizedBox(height: 10),

          //*** Description section ***
          CustomTitleOfFields("Description", padding: 20),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CustomTextField(),
          ),
          SizedBox(height: 10),

          //*** Place section ***
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
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
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CustomTextField(
              readonly: true,
              hintText: "Select places",
              suffixIcon: Icon(Icons.add),
              navigatTo: AddPlaceView(),
            ),
          ),
          SizedBox(height: 10),

          //*** Start date & End date section ***
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(
                  AppAssets.calendarIcon,
                  height: 25,
                  width: 25,
                ),
              ),
              CustomTitleOfFields("Start date", padding: 5),
              SizedBox(width: 60),
              Image.asset(AppAssets.calendarIcon, height: 25, width: 25),
              CustomTitleOfFields("End date", padding: 5),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: CustomTextField(
                    readonly: true,
                    hintText: "DD / MM / YY",
                    controller: startDateController,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2026),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        startDateController.text =
                            "${date.day} / ${date.month} / ${date.year}";
                      }
                    },
                  ),
                ),
              ),
              Image.asset(AppAssets.rightArrow, height: 25, width: 25),
              SizedBox(
                width: 160,
                child: CustomTextField(
                  readonly: true,
                  hintText: "DD / MM / YY",
                  controller: endDateController,
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2026),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      endDateController.text =
                          "${date.day} / ${date.month} / ${date.year}";
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          //*** Number of volunteers section ***
          CustomTitleOfFields("Number of volunteers", padding: 20),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CustomTextField(
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ),
          SizedBox(height: 10),

          //*** Volunteer field section ***
          CustomTitleOfFields(
            "Volunteer Field",
            padding: 20,
            requiredMark: false,
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropDownList(
              options: [
                "community service",
                "Education & Teaching",
                "Healthcare support",
                "Environmental Protection",
                "Charity & Non-profit work",
                "Event organization",
                "Adminstravtive Support",
                "Media & Content creation",
                "IT & Technical Support",
                "Human Resources Support",
                "Fundraising",
              ],
              multiValues: true,
              labeltext: "",
              icon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),

          //*** Work Location section ***
          CustomTitleOfFields("Work Location", padding: 20),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropDownList(
              options: ["On-site", "Remote", "Hyprid"],
              labeltext: "",
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
          SizedBox(height: 10),

          //*** Work Type section ***
          CustomTitleOfFields("Work type", padding: 20),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropDownList(
              options: ["Full time", "Part time", "Freelance"],
              labeltext: "",
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
          SizedBox(height: 10),

          //*** Skills you must have section ***
          CustomTitleOfFields(
            "Skills you must have",
            padding: 20,
            requiredMark: false,
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropDownList(
              options: [
                "Education",
                "Environment",
                "Empathy",
                "Event Coordination",
              ],
              multiValues: true,
              labeltext: "",
              icon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),

          //*** Skills you will acquire section ***
          CustomTitleOfFields(
            "Skills you will acquire",
            padding: 20,
            requiredMark: false,
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: DropDownList(
              options: [
                "Education",
                "Environment",
                "Empathy",
                "Event Coordination",
              ],
              multiValues: true,
              labeltext: "",
              icon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10),

          //*** Add Question button ***
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: CustomButton(
              fontColor: AppColors.textBlueDark,
              text: "+ Add Qusetions",
              color: AppColors.googleButton,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddQuestionsView()),
                );
              },
            ),
          ),
          SizedBox(height: 50),

          //*** Create opportunity button ***
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: CustomButton(text: "Create Opportunity"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
