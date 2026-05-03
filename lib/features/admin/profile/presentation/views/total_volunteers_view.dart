import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/volunteer_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/volunteer_state.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/custom_container_total_volunteer.dart';
import 'package:mosahem/features/organization/org_profile/data/models/volunteer_model.dart';

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
  // List volunteersList = [];
  // bool isInitialized = false;
  @override
  void initState() {
    super.initState();
    context.read<VolunteerCubit>().getVolunteers();
  }

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
                'Total Volunteers',
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

      body: BlocBuilder<VolunteerCubit, VolunteerState>(
        builder: (context, state) {
          if (state is VolunteerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VolunteerSuccess) {
            print(state.volunteers.length);
            final volunteers = state.volunteers;

            return ListView.builder(
              itemCount: volunteers.length,
              itemBuilder: (context, index) {
                final volunteer = volunteers[index];

                return CustomContainerTotalVolunteer(
                  volunteerName: volunteer.name,
                  bio: volunteer.bio ?? "No bio",
                  profilePhoto:
                      (volunteer.image != null && volunteer.image!.isNotEmpty)
                      ? volunteer.image!
                      : AppAssets.profilePhotoIcon,
                  onDelete: () {
                    context.read<VolunteerCubit>().getVolunteers();
                  },
                );
              },
            );
          } else if (state is VolunteerError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
