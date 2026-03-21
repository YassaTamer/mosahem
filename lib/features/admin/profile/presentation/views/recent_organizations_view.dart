import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/custom_container_recent_org.dart';

class RecentOrganizationsView extends StatefulWidget {
  const RecentOrganizationsView({super.key});

  @override
  State<RecentOrganizationsView> createState() =>
      _RecentOrganizationsViewState();
}

class _RecentOrganizationsViewState extends State<RecentOrganizationsView> {
  List<String> orgLogos = [
    AppAssets.orgLogo,
    AppAssets.orgLogo,
    AppAssets.orgLogo,
    AppAssets.orgLogo,
    AppAssets.orgLogo,
  ];

  List<String> orgNames = [
    "Icpc",
    "Baheya",
    "Bank Altaam",
    "Wazaf",
    "Microsoft",
  ];

  List<String> dates = [
    "10/2/2026",
    "5/3/2026",
    "12/3/2026",
    "12/4/2026",
    "15/4/2026",
  ];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        leading: const BackButton(),

        title: isSearching
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              )
            : CustomText(
                'Recent Organizations',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (isSearching) {
                    searchController.clear();
                  }
                  isSearching = !isSearching;
                });
              },
              icon: isSearching
                  ? const Icon(Icons.close)
                  : Image.asset(AppAssets.searchIcon, width: 40, height: 40),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: orgLogos.length,
        itemBuilder: (context, index) {
          return CustomContainerRecentOrg(
            orgLogo: orgLogos[index],
            orgName: orgNames[index],
            date: dates[index],
          );
        },
      ),
    );
  }
}
