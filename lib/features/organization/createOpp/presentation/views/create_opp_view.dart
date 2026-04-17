import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/app_snackbar_helper.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/core/network/network_request_flags.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/data/models/track_model.dart';
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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<TrackModel> tracks = [];

  Future<void> getTracks() async {
    try {
      final response = await DioHelper.instance.client.get(
        'https://mosahemapi.runasp.net/api/v1/fields/get-all-fields',
        options: Options(extra: {kSkipAuth: true, kSkipRefresh: true}),
      );

      if (!mounted) return;

      if (response.statusCode == 200 && response.data['Succeeded'] == true) {
        final List data = response.data['Data'];
        setState(() {
          tracks = data.map((e) => TrackModel.fromJson(e)).toList();
        });
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    getTracks();
  }

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
          CreateOpportunityCubit(context.read<CreateOpportunityRepository>())
            ..getSkills(),
      child: BlocConsumer<CreateOpportunityCubit, CreateOpportunityState>(
        listenWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        listener: (context, state) {
          if (state.submissionStatus ==
              CreateOpportunitySubmissionStatus.success) {
            AppSnackBarHelper.success(
              context,
              'Opportunity created successfully.',
            );
          }

          if (state.submissionStatus ==
              CreateOpportunitySubmissionStatus.error) {
            AppSnackBarHelper.error(
              context,
              state.submissionErrorMessage ?? 'Failed to create opportunity.',
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CreateOpportunityCubit>();
          final trackOptions = tracks
              .map(
                (track) => DropDownOption(value: track.id, label: track.name),
              )
              .toList(growable: false);
          final skillOptions = cubit.skills
              .map(
                (skill) => DropDownOption(value: skill.id, label: skill.name),
              )
              .toList(growable: false);
          final isSkillsLoading =
              state.skillsStatus == SkillsRequestStatus.loading;
          final areSkillsReady =
              state.skillsStatus == SkillsRequestStatus.success &&
              skillOptions.isNotEmpty;
          final isSubmitting =
              state.submissionStatus ==
              CreateOpportunitySubmissionStatus.loading;

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
                const Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: ImageUploadWidget(),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColors.primaryDark,
                  endIndent: 20,
                  indent: 20,
                ),
                const SizedBox(height: 10),
                const CustomTitleOfFields('Title of opportunitiy', padding: 20),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
                    textEditingController: titleController,
                    onChange: (value) {
                      cubit.opportunity.title = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const CustomTitleOfFields('Description', padding: 20),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
                    textEditingController: descriptionController,
                    onChange: (value) {
                      cubit.opportunity.description = value;
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
                    const CustomTitleOfFields('Place', padding: 5),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
                    readonly: true,
                    hintText: 'Select places',
                    suffixIcon: const Icon(Icons.add),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const AddPlaceView(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
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
                    const CustomTitleOfFields('Start date', padding: 5),
                    const SizedBox(width: 60),
                    Image.asset(AppAssets.calendarIcon, height: 25, width: 25),
                    const CustomTitleOfFields('End date', padding: 5),
                  ],
                ),
                const SizedBox(height: 5),
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
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2026),
                              lastDate: DateTime(2100),
                            );
                            if (!mounted || date == null) return;

                            startDateController.text =
                                '${date.day} / ${date.month} / ${date.year}';
                            cubit.opportunity.startDate = date
                                .toIso8601String();
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
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2026),
                            lastDate: DateTime(2100),
                          );
                          if (!mounted || date == null) return;

                          endDateController.text =
                              '${date.day} / ${date.month} / ${date.year}';
                          cubit.opportunity.endDate = date.toIso8601String();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const CustomTitleOfFields('Number of volunteers', padding: 20),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomTextField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    onChange: (value) {
                      cubit.opportunity.numberOfVolunteers = int.tryParse(
                        value,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const CustomTitleOfFields(
                  'Volunteer Field',
                  padding: 20,
                  requiredMark: false,
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDownList(
                    options: trackOptions,
                    multiValues: true,
                    labeltext: '',
                    icon: const Icon(Icons.search),
                    hintText: 'Select volunteer fields',
                    enabled: trackOptions.isNotEmpty,
                    onMultiChanged: cubit.updateFieldIds,
                  ),
                ),
                const SizedBox(height: 10),
                const CustomTitleOfFields('Work Location', padding: 20),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDownList(
                    options: const [
                      DropDownOption(value: 'On-site', label: 'On-site'),
                      DropDownOption(value: 'Remote', label: 'Remote'),
                      DropDownOption(value: 'Hybrid', label: 'Hybrid'),
                    ],
                    labeltext: '',
                    icon: const Icon(Icons.arrow_drop_down),
                    hintText: 'Select work location',
                    onChanged: (value) {
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
                const SizedBox(height: 10),
                const CustomTitleOfFields('Work type', padding: 20),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDownList(
                    options: const [
                      DropDownOption(value: 'Full time', label: 'Full time'),
                      DropDownOption(value: 'Part time', label: 'Part time'),
                      DropDownOption(value: 'Freelance', label: 'Freelance'),
                    ],
                    labeltext: '',
                    icon: const Icon(Icons.arrow_drop_down),
                    hintText: 'Select work type',
                    onChanged: (value) {
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
                const SizedBox(height: 10),
                const CustomTitleOfFields(
                  'Skills you must have',
                  padding: 20,
                  requiredMark: false,
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDownList(
                    options: skillOptions,
                    multiValues: true,
                    labeltext: '',
                    icon: const Icon(Icons.search),
                    hintText: isSkillsLoading
                        ? 'Loading skills...'
                        : 'Select required skills',
                    enabled: areSkillsReady,
                    onMultiChanged: cubit.updateRequiredSkillIds,
                  ),
                ),
                if (state.skillsStatus == SkillsRequestStatus.error)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: CustomText(
                      state.skillsErrorMessage ?? 'Failed to load skills.',
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(height: 10),
                const CustomTitleOfFields(
                  'Skills you will acquire',
                  padding: 20,
                  requiredMark: false,
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropDownList(
                    options: skillOptions,
                    multiValues: true,
                    labeltext: '',
                    icon: const Icon(Icons.search),
                    hintText: isSkillsLoading
                        ? 'Loading skills...'
                        : 'Select acquired skills',
                    enabled: areSkillsReady,
                    onMultiChanged: cubit.updateProvidedSkillIds,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    fontColor: AppColors.textBlueDark,
                    text: '+ Add Qusetions',
                    color: AppColors.googleButton,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: const AddQuestionsView(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: CustomButton(
                    text: isSubmitting ? 'Creating...' : 'Create Opportunity',
                    onTap: isSubmitting ? null : cubit.createOpportunity,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
