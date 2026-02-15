import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/auth/data/models/city_model.dart';
import 'package:mosahem/features/auth/data/models/governorate_model.dart';
import 'package:mosahem/features/auth/data/repository/location_repository.dart';
import 'package:mosahem/features/auth/presentation/views/select_tracks_view.dart';
import 'package:mosahem/features/auth/presentation/widgets/labeled_field_row.dart';
import 'package:mosahem/features/auth/presentation/widgets/labled_text_field_row.dart';

class AddBranchLocationView extends StatefulWidget {
  const AddBranchLocationView({super.key});

  @override
  State<AddBranchLocationView> createState() => _AddBranchLocationViewState();
}

class _AddBranchLocationViewState extends State<AddBranchLocationView> {
  String? selectedGovernorate;
  String? selectedCity;
  late final LocationRepository _locationRepository;

  @override
  void initState() {
    super.initState();
    _locationRepository = LocationRepository(Dio());
    fetchGovernorates();
  }

  List<GovernorateModel> governorates = [];
  List<CityModel> cities = [];
  Future<void> fetchGovernorates() async {
    try {
      final result = await _locationRepository.getGovernorates();

      setState(() {
        governorates = result;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCities(String governorateId) async {
    try {
      setState(() {
        isCitiesLoading = true;
        cities = [];
        selectedCity = null;
      });

      final data = await _locationRepository.getCities(governorateId);

      setState(() {
        cities = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isCitiesLoading = false;
      });
    }
  }

  String? governorateError;
  String? cityError;
  bool isCitiesLoading = false;

  Map<String, String>? branch;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledFieldRow(
                            label: 'Governorate:',
                            hint: selectedGovernorate ?? 'Select Governorate',
                            isRequired: true,
                            items: governorates.map((e) => e.name).toList(),

                            onSelect: (value) {
                              final gov = governorates.firstWhere(
                                (element) => element.name == value,
                              );

                              setState(() {
                                selectedGovernorate = value;
                                selectedCity = null;
                                governorateError = null;
                                cities = [];
                              });
                              fetchCities(gov.id);
                            },
                          ),
                          if (governorateError != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 120, top: 4),
                              child: CustomText(
                                governorateError!,
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                      Gap(6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledFieldRow(
                            label: 'City:',
                            hint: isCitiesLoading
                                ? "Loading..."
                                : selectedCity ?? "Select City",
                            isRequired: true,
                            items: cities.map((e) => e.name).toList(),

                            onSelect: (value) {
                              setState(() {
                                selectedCity = value;
                                cityError = null;
                              });
                            },
                          ),
                          if (cityError != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 120, top: 4),
                              child: CustomText(
                                cityError!,
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                      Gap(6),
                      LabeledTextFieldRow(
                        controller: addressController,

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
                              controller: descriptionController,
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
                              onTap: () {
                                bool isValid = true;

                                if (selectedGovernorate == null) {
                                  governorateError = "Governorate is required";
                                  isValid = false;
                                }

                                if (selectedCity == null) {
                                  cityError = "City is required";
                                  isValid = false;
                                }

                                setState(() {});

                                if (!isValid) return;

                                setState(() {
                                  branch = {
                                    "governorate": selectedGovernorate!,
                                    "city": selectedCity!,
                                    "address": addressController.text,
                                    "description": descriptionController.text,
                                  };
                                  addressController.clear();
                                  descriptionController.clear();
                                  selectedGovernorate = null;
                                  selectedCity = null;
                                  cities = [];
                                });
                              },

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
                if (branch != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD8B50C)),
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
                                  branch!["governorate"]!,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                                CustomText(
                                  branch!["city"]!,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                                CustomText(
                                  branch!["address"]!,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                                CustomText(
                                  branch!["description"]!,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                branch = null;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                Gap(4),
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
                color: branch == null
                    ? AppColors.greyLight
                    : AppColors.primaryDark,
                onTap: branch == null
                    ? null
                    : () {
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
