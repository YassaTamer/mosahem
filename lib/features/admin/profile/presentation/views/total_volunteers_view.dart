import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/custom_container_total_volunteer.dart';

class TotalVolunteersView extends StatefulWidget {
  const TotalVolunteersView({super.key});

  @override
  State<TotalVolunteersView> createState() => _TotalVolunteersViewState();
}

class _TotalVolunteersViewState extends State<TotalVolunteersView> {
  List<String> volunteers = [
    "Betty Bassem",
    "Yassa Shahat",
    "Mario Nabil",
    "Margret Mikhael",
    "Steven Nabil",
    "Kerolos Nage",
  ];
  List<String> bios = [
    "Beach Cleanup",
    "garden Keeper",
    "Baby setter",
    "Beach Cleanup",
    "garden Keeper",
    "Baby setter",
  ];
  List<String> profilephotos = [
    AppAssets.profilePhotoIcon,
    AppAssets.profilePhotoIcon,
    AppAssets.profilePhotoIcon,
    AppAssets.profilePhotoIcon,
    AppAssets.profilePhotoIcon,
    AppAssets.profilePhotoIcon,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Total Volunteers',
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(AppAssets.searchIcon, width: 40, height: 40),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          return CustomContainerTotalVolunteer(
            volunteerName: volunteers[index],
            bio: bios[index],
            profilePhoto: profilephotos[index],
            onDelete: () {
              setState(() {
                volunteers.removeAt(index);
                bios.removeAt(index);
                profilephotos.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }
}
