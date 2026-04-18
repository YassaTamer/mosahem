import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/constants/user_role.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/core/network/network_request_flags.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/data/models/track_model.dart';
import 'package:mosahem/features/auth/logic/cubit/auth/auth_cubit.dart';
import 'package:mosahem/features/layout/presentation/views/main_layout_view.dart';
import 'package:mosahem/features/organization/presentation/views/organization_home_view.dart';

class SelectTracksView extends StatefulWidget {
  final UserRole role;

  const SelectTracksView({super.key, this.role = UserRole.organization});

  @override
  State<SelectTracksView> createState() => _SelectTracksViewState();
}

class _SelectTracksViewState extends State<SelectTracksView> {
  bool get _isVolunteer => widget.role == UserRole.volunteer;

  List<TrackModel> tracks = [];
  List<String> selectedTrackIds = [];
  List<TrackModel> skills = [];
  List<String> selectedSkillIds = [];

  Future<void> getTracks() async {
    try {
      final response = await DioHelper.instance.client.get(
        'https://mosahemapi.runasp.net/api/v1/fields/get-all-fields',
        options: Options(extra: {kSkipAuth: true, kSkipRefresh: true}),
      );

      if (response.statusCode == 200 && response.data['Succeeded'] == true) {
        final List data = response.data['Data'];
        setState(() {
          tracks = data.map((e) => TrackModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> getSkills() async {
    try {
      final response = await DioHelper.instance.client.get(
        'https://mosahemapi.runasp.net/api/v1/skills',
        options: Options(extra: {kSkipAuth: true, kSkipRefresh: true}),
      );

      if (response.statusCode == 200 && response.data['Succeeded'] == true) {
        final List data = response.data['Data'];
        setState(() {
          skills = data
              .map((e) {
                final map = (e as Map).cast<String, dynamic>();
                final id =
                    map['SkillId']?.toString() ?? map['Id']?.toString() ?? '';
                final name = map['Name']?.toString() ?? '';
                if (id.isEmpty || name.isEmpty) return null;
                return TrackModel(id: id, name: name);
              })
              .whereType<TrackModel>()
              .toList();
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AuthCubit>();
    if (_isVolunteer) {
      selectedTrackIds = List<String>.from(cubit.volunteerFieldIds);
      selectedSkillIds = List<String>.from(cubit.volunteerSkillIds);
    }
    getTracks();
    if (_isVolunteer) {
      getSkills();
    }
  }

  Widget _buildSelectionWrap({
    required List<TrackModel> items,
    required List<String> selectedIds,
  }) {
    return Wrap(
      spacing: 10,
      runSpacing: 7,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final bool isSelected = selectedIds.contains(item.id);

        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIds.contains(item.id)) {
                selectedIds.remove(item.id);
              } else {
                selectedIds.add(item.id);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryDark : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryDark),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: CustomText(
                item.name,
                color: isSelected ? AppColors.white : AppColors.primaryDark,
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthRegistered) {
          Navigator.pop(context);

          if (_isVolunteer) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const MainLayoutView(role: UserRole.volunteer),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const OrganizationHomeView()),
              (route) => false,
            );
          }
        }
        if (state is AuthError) {
          Navigator.pop(context);

          String errorMessage = state.message;
          if (state.fieldErrors != null && state.fieldErrors!.isNotEmpty) {
            errorMessage += "\n\n";
            state.fieldErrors!.forEach((key, value) {
              errorMessage += "$key: $value\n";
            });
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(errorMessage)));
        }
      },
      child: Scaffold(
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Select Tracks',
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                Gap(6),
                CustomText(
                  _isVolunteer
                      ? 'Please select your volunteer tracks and skills.'
                      : 'Please select the volunteer tracks your orgnization.',
                  color: Color(0xff072132),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                Gap(12),
                Divider(color: AppColors.greyLight, thickness: 1.2),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          _isVolunteer ? 'Tracks' : 'Organization Tracks',
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                        Gap(8),
                        _buildSelectionWrap(
                          items: tracks,
                          selectedIds: selectedTrackIds,
                        ),
                        if (_isVolunteer) ...[
                          Gap(20),
                          CustomText(
                            'Skills',
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                          Gap(8),
                          _buildSelectionWrap(
                            items: skills,
                            selectedIds: selectedSkillIds,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Row(
            children: [
              if (!_isVolunteer) ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OrganizationHomeView()),
                    );
                  },
                  child: const CustomText(
                    'Skip',
                    color: Color(0xffD8B50C),
                    fontSize: 18,
                  ),
                ),
                const Gap(12),
              ],
              Expanded(
                child: CustomButton(
                  text: 'Continue',
                  color: AppColors.primaryDark,
                  onTap:
                      (_isVolunteer &&
                              (selectedTrackIds.isEmpty ||
                                  selectedSkillIds.isEmpty)) ||
                          (!_isVolunteer && selectedTrackIds.isEmpty)
                      ? null
                      : () {
                          final cubit = context.read<AuthCubit>();

                          if (_isVolunteer) {
                            cubit.volunteerFieldIds = List<String>.from(
                              selectedTrackIds,
                            );
                            cubit.volunteerSkillIds = List<String>.from(
                              selectedSkillIds,
                            );
                            if (cubit.fullName == null ||
                                cubit.volunteerEmail == null ||
                                cubit.volunteerPhone == null ||
                                cubit.volunteerPassword == null ||
                                cubit.dateOfBirth == null ||
                                cubit.gender == null ||
                                cubit.nationalId == null ||
                                cubit.governorateId == null ||
                                cubit.cityId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please complete all previous steps",
                                  ),
                                ),
                              );
                              return;
                            }

                            cubit.registerVolunteer();
                            cubit.registerVolunteer();
                          } else {
                            cubit.registerOrganization(
                              organizationName: cubit.organizationName!,
                              email: cubit.email!,
                              phoneNumber: cubit.phoneNumber!,
                              password: cubit.password!,
                              locations: cubit.locations,
                              fieldIds: selectedTrackIds,
                              licenseUrl: cubit.licenseUrl,
                              description: "",
                            );
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
