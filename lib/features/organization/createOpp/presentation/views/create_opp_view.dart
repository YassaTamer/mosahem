import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/presentation/views/add_branch_location_view.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';
import 'package:mosahem/features/organization/createOpp/logic/cubit/create_opportunity_cubit.dart';
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
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreateOpportunityCubit(context.read<CreateOpportunityRepository>()),
      child: Builder(
        builder: (context) {
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
                CustomTitleOfFields('Title of opportunitiy', padding: 20),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomTextField(
                    onChange: (value) {
                      context.read<CreateOpportunityCubit>().opportunity.title =
                          value;
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields('Description', padding: 20),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomTextField(
                    onChange: (value) {
                      context
                              .read<CreateOpportunityCubit>()
                              .opportunity
                              .description =
                          value;
                    },
                  ),
                ),
                SizedBox(height: 10),
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
                    CustomTitleOfFields('Place', padding: 5),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomTextField(
                    readonly: true,
                    hintText: 'Select places',
                    suffixIcon: Icon(Icons.add),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CreateOpportunityCubit>(),
                            child: const AddPlaceView(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
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
                    CustomTitleOfFields('Start date', padding: 5),
                    SizedBox(width: 60),
                    Image.asset(AppAssets.calendarIcon, height: 25, width: 25),
                    CustomTitleOfFields('End date', padding: 5),
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
                          hintText: 'DD / MM / YY',
                          textEditingController: startDateController,
                          onTap: () async {
                            final cubit = context
                                .read<CreateOpportunityCubit>();

                            DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2026),
                              lastDate: DateTime(2100),
                            );
                            if (!mounted) return;
                            if (date != null) {
                              startDateController.text =
                                  '${date.day} / ${date.month} / ${date.year}';

                              cubit.opportunity.startDate = date
                                  .toIso8601String();
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
                        hintText: 'DD / MM / YY',
                        textEditingController: endDateController,
                        onTap: () async {
                          final cubit = context.read<CreateOpportunityCubit>();

                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2026),
                            lastDate: DateTime(2100),
                          );
                          if (!mounted) return;
                          if (date != null) {
                            endDateController.text =
                                '${date.day} / ${date.month} / ${date.year}';
                            cubit.opportunity.endDate = date.toIso8601String();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomTitleOfFields('Number of volunteers', padding: 20),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomTextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    onChange: (value) {
                      context
                          .read<CreateOpportunityCubit>()
                          .opportunity
                          .numberOfVolunteers = int.tryParse(
                        value,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields(
                  'Volunteer Field',
                  padding: 20,
                  requiredMark: false,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropDownList(
                    options: [
                      'community service',
                      'Education & Teaching',
                      'Healthcare support',
                      'Environmental Protection',
                      'Charity & Non-profit work',
                      'Event organization',
                      'Adminstravtive Support',
                      'Media & Content creation',
                      'IT & Technical Support',
                      'Human Resources Support',
                      'Fundraising',
                    ],
                    multiValues: true,
                    labeltext: '',
                    icon: Icon(Icons.search),
                    onMultiChanged: (values) {
                      context
                              .read<CreateOpportunityCubit>()
                              .opportunity
                              .fieldIds =
                          values;
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields('Work Location', padding: 20),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropDownList(
                    options: ['On-site', 'Remote', 'Hybrid'],
                    labeltext: '',
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (value) {
                      final cubit = context.read<CreateOpportunityCubit>();
                      if (value == 'On-site') {
                        cubit.opportunity.locationType = 0;
                      } else if (value == 'Remote') {
                        cubit.opportunity.locationType = 1;
                      } else if (value == 'Hybrid') {
                        cubit.opportunity.locationType = 2;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields('Work type', padding: 20),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropDownList(
                    options: ['Full time', 'Part time', 'Freelance'],
                    labeltext: '',
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (value) {
                      final cubit = context.read<CreateOpportunityCubit>();

                      if (value == 'Full time') {
                        cubit.opportunity.workType = 0;
                      } else if (value == 'Part time') {
                        cubit.opportunity.workType = 1;
                      } else if (value == 'Freelance') {
                        cubit.opportunity.workType = 2;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields(
                  'Skills you must have',
                  padding: 20,
                  requiredMark: false,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropDownList(
                    options: [
                      'Education',
                      'Environment',
                      'Empathy',
                      'Event Coordination',
                    ],
                    multiValues: true,
                    labeltext: '',
                    icon: Icon(Icons.search),
                    onMultiChanged: (values) {
                      context
                              .read<CreateOpportunityCubit>()
                              .opportunity
                              .requiredSkillIds =
                          values;
                    },
                  ),
                ),
                SizedBox(height: 10),
                CustomTitleOfFields(
                  'Skills you will acquire',
                  padding: 20,
                  requiredMark: false,
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: DropDownList(
                    options: [
                      'Education',
                      'Environment',
                      'Empathy',
                      'Event Coordination',
                    ],
                    multiValues: true,
                    labeltext: '',
                    icon: Icon(Icons.search),
                    onMultiChanged: (values) {
                      context
                              .read<CreateOpportunityCubit>()
                              .opportunity
                              .providedSkillIds =
                          values;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CustomButton(
                    fontColor: AppColors.textBlueDark,
                    text: '+ Add Qusetions',
                    color: AppColors.googleButton,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CreateOpportunityCubit>(),
                            child: const AddQuestionsView(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: CustomButton(
                    text: 'Create Opportunity',
                    onTap: () {
                      context
                          .read<CreateOpportunityCubit>()
                          .createOpportunity();
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
