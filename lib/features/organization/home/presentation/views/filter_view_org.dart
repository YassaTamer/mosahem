import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/core/widgets/filter_category.dart';
import 'package:mosahem/features/organization/home/presentation/views/org_home_view.dart';

class FilterViewOrg extends StatefulWidget {
  const FilterViewOrg({super.key});

  @override
  State<FilterViewOrg> createState() => _FilterViewOrgState();
}

class _FilterViewOrgState extends State<FilterViewOrg> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<String> selectedWorkType = [];
  List<String> selectedLocationType = [];
  List<String> selectedOppStatus = [];
  List<String> selectedSkillsMustHave = [];
  List<String> selectedSkillsWillAcquire = [];
  List<String> selectedFields = [];
  List<String> selectedGovernment = [];
  final TextEditingController startDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(backgroundColor: AppColors.white, toolbarHeight: 10),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: isSearching
                      ? Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            onSubmitted: (_) {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: AppColors.primary.withAlpha(
                                  (255 * 0.5).toInt(),
                                ),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Image.asset(AppAssets.searchIcon),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    isSearching = false;
                                    searchController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CustomText(
                                  "Search",
                                  fontSize: 20,
                                  color: AppColors.primary.withAlpha(
                                    (255 * 0.5).toInt(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 190),
                              Image.asset(AppAssets.searchIcon),
                            ],
                          ),
                        ),
                ),

                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrgHomeView()),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(AppAssets.filterIconWhite),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                FilterCategory(
                  categoryName: "Work Type",
                  options: ["Full-time", "Part-time"],
                  selectedItems: selectedWorkType,
                  onSelect: (item) {
                    setState(() {
                      if (selectedWorkType.contains(item)) {
                        selectedWorkType.remove(item);
                      } else {
                        selectedWorkType = [item];
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Location Type",
                  options: ["Onsite", "Hypered", "Remote"],
                  selectedItems: selectedLocationType,
                  onSelect: (item) {
                    setState(() {
                      if (selectedLocationType.contains(item)) {
                        selectedLocationType.remove(item);
                      } else {
                        selectedLocationType = [item];
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Opportunity Status",
                  options: ["Open", "Active", "Closed", "Ended", "Stopped"],
                  selectedItems: selectedOppStatus,
                  onSelect: (item) {
                    setState(() {
                      if (selectedOppStatus.contains(item)) {
                        selectedOppStatus.remove(item);
                      } else {
                        selectedOppStatus = [item];
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Skills You Must Have",
                  options: [
                    "Education",
                    "Child Care",
                    "Environment",
                    "Healthcare",
                    "Arts & Culture",
                    "Community services",
                    "Technology",
                  ],
                  selectedItems: selectedSkillsMustHave,
                  onSelect: (item) {
                    setState(() {
                      if (selectedSkillsMustHave.contains(item)) {
                        selectedSkillsMustHave.remove(item);
                      } else {
                        selectedSkillsMustHave.add(item);
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Skills You Will Acquire",
                  options: [
                    "Marketing",
                    "Child Care",
                    "Human Rights",
                    "Technology",
                    "Arts & Culture",
                    "Youth Development",
                    "Healthcare",
                  ],
                  selectedItems: selectedSkillsWillAcquire,
                  onSelect: (item) {
                    setState(() {
                      if (selectedSkillsWillAcquire.contains(item)) {
                        selectedSkillsWillAcquire.remove(item);
                      } else {
                        selectedSkillsWillAcquire.add(item);
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Fields",
                  options: [
                    "Marketing",
                    "Child Care",
                    "Human Rights",
                    "Technology",
                    "Arts & Culture",
                    "Community Services",
                    "Healthcare",
                  ],
                  selectedItems: selectedFields,
                  onSelect: (item) {
                    setState(() {
                      if (selectedFields.contains(item)) {
                        selectedFields.remove(item);
                      } else {
                        selectedFields.add(item);
                      }
                    });
                  },
                ),

                SizedBox(height: 20),

                FilterCategory(
                  categoryName: "Government",
                  options: [
                    "Alexandria",
                    "Beheira",
                    "Kafr-EL Sheikh",
                    "Dakahlia",
                    "Luxor",
                    "North Sinai",
                    "Aswan",
                    "Port Said",
                    "Damietta",
                    "Sharqia",
                    "Gharbia",
                    "Monufia",
                    "Giza",
                    "Suez",
                    "Qena",
                    "Minya",
                    "Cairo",
                    "Qalyubia",
                    "Beni Sueif",
                    "Faiyum",
                    "Asyut",
                    "Sohag",
                    "South Sinai",
                    "Matrouh",
                    "New Valley",
                    "Red Sea",
                    "Ismailia",
                  ],
                  selectedItems: selectedGovernment,
                  onSelect: (item) {
                    setState(() {
                      if (selectedGovernment.contains(item)) {
                        selectedGovernment.remove(item);
                      } else {
                        selectedGovernment = [item];
                      }
                    });
                  },
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 15,
                  ),
                  child: CustomText(
                    "Start Date",
                    color: AppColors.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 15,
                  ),
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
