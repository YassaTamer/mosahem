import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';
import 'package:mosahem/features/admin/profile/presentation/views/accepted_opp_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/rejected_opp_view.dart';

class TotalOpportunitiesView extends StatefulWidget {
  const TotalOpportunitiesView({super.key});

  @override
  State<TotalOpportunitiesView> createState() => _TotalOpportunitiesViewState();
}

class _TotalOpportunitiesViewState extends State<TotalOpportunitiesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color indicatorColor = Colors.green;

  @override
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        context.read<OpportunityCubit>().getOpportunities("approved");
      } else {
        context.read<OpportunityCubit>().getOpportunities("rejected");
      }

      setState(() {
        indicatorColor = _tabController.index == 0 ? Colors.green : Colors.red;
      });
    });

    context.read<OpportunityCubit>().getOpportunities("approved");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                'Total Opportunities',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),

        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: IconButton(
        //       onPressed: () {
        //         setState(() {
        //           if (isSearching) {
        //             searchController.clear();
        //           }
        //           isSearching = !isSearching;
        //         });
        //       },
        //       icon: isSearching
        //           ? const Icon(Icons.close)
        //           : Image.asset(AppAssets.searchIcon, width: 40, height: 40),
        //     ),
        //   ),
        // ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: indicatorColor,
          tabs: const [
            Tab(
              child: Text(
                "Accepted",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                "Rejected",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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

            //   return TabBarView(
            //     controller: _tabController,
            //     children: [
            //       ListView.builder(
            //         itemCount: orgLogos.length,
            //         itemBuilder: (context, index) {
            //           return AcceptedOppView(
            //             orgLogo: orgLogos[index],
            //             orgName: orgNames[index],
            //             oppName: oppNames[index],
            //             startDate: startDates[index],
            //             endDate: endDates[index],
            //           );
            //         },
            //       ),

            //       ListView.builder(
            //         itemCount: orgLogos.length,
            //         itemBuilder: (context, index) {
            //           return RejectedOppView(
            //             orgLogo: orgLogos[index],
            //             orgName: orgNames[index],
            //             oppName: oppNames[index],
            //             startDate: startDates[index],
            //             endDate: endDates[index],
            //           );
            //         },
            //       ),
            //     ],
            //   );
            // }

            //  final opportunities = state.opportunities;

            final accepted = opportunities
                .where((e) => (e.status ?? '').toLowerCase() == 'approved')
                .toList();

            final rejected = opportunities
                .where((e) => (e.status ?? '').toLowerCase() == 'rejected')
                .toList();

            return TabBarView(
              controller: _tabController,
              children: [
                // ✅ Accepted
                ListView.builder(
                  itemCount: accepted.length,
                  itemBuilder: (context, index) {
                    final opp = accepted[index];

                    return AcceptedOppView(
                      orgLogo: (opp.logoUrl != null && opp.logoUrl!.isNotEmpty)
                          ? opp.logoUrl!
                          : AppAssets.orgLogo,
                      orgName: opp.organizationName,
                      oppName: opp.name,
                      startDate: opp.startDate,
                      endDate: opp.endDate,
                    );
                  },
                ),

                // ✅ Rejected
                ListView.builder(
                  itemCount: rejected.length,
                  itemBuilder: (context, index) {
                    final opp = rejected[index];

                    return RejectedOppView(
                      orgLogo: (opp.logoUrl != null && opp.logoUrl!.isNotEmpty)
                          ? opp.logoUrl!
                          : AppAssets.orgLogo,
                      orgName: opp.organizationName,
                      oppName: opp.name,
                      startDate: opp.startDate,
                      endDate: opp.endDate,
                    );
                  },
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
