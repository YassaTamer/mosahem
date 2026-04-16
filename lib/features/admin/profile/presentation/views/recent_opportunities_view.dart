import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';
import 'package:mosahem/features/admin/profile/presentation/widgets/custom_container_recent_opp.dart';

class RecentOpportunitiesView extends StatefulWidget {
  const RecentOpportunitiesView({super.key});

  @override
  State<RecentOpportunitiesView> createState() =>
      _RecentOpportunitiesViewState();
}

class _RecentOpportunitiesViewState extends State<RecentOpportunitiesView> {
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

  List<String> oppNames = [
    "Content Creator",
    "Organizing",
    "Organizing",
    "Helping Staff",
    "Programming internship",
  ];

  List<String> startDates = [
    "10/2/2026",
    "5/3/2026",
    "12/3/2026",
    "12/4/2026",
    "15/4/2026",
  ];

  List<String> endDates = [
    "10/2/2026",
    "5/3/2026",
    "12/3/2026",
    "12/4/2026",
    "15/4/2026",
  ];
  @override
  void initState() {
    super.initState();

    context.read<OpportunityCubit>().getOpportunities("pending");
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
                'Recent Opportunities',
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

      body: BlocBuilder<OpportunityCubit, OpportunityState>(
        builder: (context, state) {
          if (state is OpportunityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OpportunityError) {
            return Center(child: Text(state.message));
          }

          if (state is OpportunitySuccess) {
            final opportunities = state.opportunities;
            return ListView.builder(
              itemCount: opportunities.length,
              itemBuilder: (context, index) {
                final opp = opportunities[index];

                return CustomContainerRecentOpp(
                  orgLogo: (opp.logoUrl != null && opp.logoUrl!.isNotEmpty)
                      ? opp.logoUrl!
                      : AppAssets.orgLogo,
                  orgName: opp.organizationName,
                  oppName: opp.name,
                  startDate: DateHelper.format(opp.startDate),
                  endDate: DateHelper.format(opp.endDate),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
