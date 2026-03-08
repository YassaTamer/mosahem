import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_button.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/auth/data/models/city_model.dart';
import 'package:mosahem/features/auth/data/models/governorate_model.dart';
import 'package:mosahem/features/auth/data/repository/location_repository.dart';
import 'package:mosahem/features/auth/presentation/widgets/labeled_field_row.dart';
import 'package:mosahem/features/auth/presentation/widgets/labled_text_field_row.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_title_of_fields.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/drop_down_list.dart';

class AddPlaceView extends StatefulWidget {
  const AddPlaceView({super.key});

  @override
  State<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends State<AddPlaceView> {
  TextEditingController descriptionController = TextEditingController();
  final governmentKey = GlobalKey();
  final cityKey = GlobalKey();
  bool get isSaveEnabled => selectedGovernorate != null && selectedCity != null;
  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _locationRepository = LocationRepository(Dio());

    fetchGovernorates(); // 👈 مهم
  }

  late final LocationRepository _locationRepository;

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

  BranchLocationModel? branch;
  final TextEditingController addressController = TextEditingController();
  List<GovernorateModel> governorates = [];
  List<CityModel> cities = [];
  String? selectedGovernorate;
  String? selectedCity;
  GovernorateModel? selectedGovernorateModel;
  CityModel? selectedCityModel;
  String? governorateError;
  String? cityError;
  bool isCitiesLoading = false;
  Future<void> fetchGovernorates() async {
    try {
      final result = await _locationRepository.getGovernorates();

      setState(() {
        governorates = result;
      });
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(
          child: CustomText(
            'Add Place',
            color: AppColors.primaryDark,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryLightBlue,
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
                Gap(12),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.locationIcon, width: 24),
                    Gap(12),
                    CustomText(
                      'New Place',
                      color: AppColors.primaryDark,
                      fontSize: 18,
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
                              if (value.isEmpty || governorates.isEmpty) {
                                setState(() {
                                  selectedGovernorate = null;
                                  selectedGovernorateModel = null;
                                  selectedCity = null;
                                  selectedCityModel = null;
                                  cities = [];
                                });
                                return;
                              }

                              final selectedName = value.first;
                              final govIndex = governorates.indexWhere(
                                (element) => element.name == selectedName,
                              );

                              if (govIndex == -1) {
                                setState(() {
                                  selectedGovernorate = null;
                                  selectedGovernorateModel = null;
                                  selectedCity = null;
                                  selectedCityModel = null;
                                  cities = [];
                                });
                                return;
                              }

                              final gov = governorates[govIndex];
                              setState(() {
                                selectedGovernorate = selectedName;
                                selectedGovernorateModel = gov;
                                selectedCity = null;
                                selectedCityModel = null;
                                governorateError = null;
                                cities = [];
                              });
                              fetchCities(gov.id);
                            },
                            selectedItems: selectedGovernorate == null
                                ? []
                                : [selectedGovernorate!],
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
                              if (value.isEmpty || cities.isEmpty) {
                                setState(() {
                                  selectedCity = null;
                                  selectedCityModel = null;
                                });
                                return;
                              }

                              final selectedName = value.first;
                              final cityIndex = cities.indexWhere(
                                (element) => element.name == selectedName,
                              );

                              if (cityIndex == -1) {
                                setState(() {
                                  selectedCity = null;
                                  selectedCityModel = null;
                                });
                                return;
                              }

                              final city = cities[cityIndex];
                              setState(() {
                                selectedCity = selectedName;
                                selectedCityModel = city;
                                cityError = null;
                              });
                            },
                            selectedItems: selectedCity == null
                                ? []
                                : [selectedCity!],
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
                      // LabeledTextFieldRow(
                      //   controller: addressController,
                      //   label: 'Branch Address:',
                      //   hint: 'enter full address',
                      //   isRequired: true,
                      // ),
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

                                if (selectedGovernorateModel == null) {
                                  governorateError = "Governorate is required";
                                  isValid = false;
                                }

                                if (selectedCityModel == null) {
                                  cityError = "City is required";
                                  isValid = false;
                                }

                                setState(() {});
                                if (!isValid) return;
                                final newBranch = BranchLocationModel(
                                  governorateId: selectedGovernorateModel!.id,
                                  cityId: selectedCityModel!.id,
                                  details: descriptionController.text,
                                  governorateName: selectedGovernorate!,
                                  cityName: selectedCity!,
                                  address: addressController.text,
                                );

                                // // ✅ خزنه في الكيوبت
                                // context.read<AuthCubit>().locations.add(
                                //   newBranch,
                                // );

                                setState(() {
                                  branch = newBranch;

                                  addressController.clear();
                                  descriptionController.clear();
                                  selectedGovernorate = null;
                                  selectedCity = null;
                                  selectedGovernorateModel = null;
                                  selectedCityModel = null;
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
                                  branch!.governorateName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                                CustomText(
                                  branch!.cityName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                                // CustomText(
                                //   branch!.address,
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w800,
                                //   color: AppColors.primaryDark,
                                // ),
                                CustomText(
                                  branch!.details,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                  maxLines: 3,
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
    );
  }
}
