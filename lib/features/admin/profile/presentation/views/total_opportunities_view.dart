import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
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
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        indicatorColor = _tabController.index == 0 ? Colors.green : Colors.red;
      });
    });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryLightBlue,
        title: CustomText(
          'Total Opportunities',
          fontSize: 18,
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

      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
            itemCount: orgLogos.length,
            itemBuilder: (context, index) {
              return AcceptedOppView(
                orgLogo: orgLogos[index],
                orgName: orgNames[index],
                oppName: oppNames[index],
                startDate: startDates[index],
                endDate: endDates[index],
              );
            },
          ),

          ListView.builder(
            itemCount: orgLogos.length,
            itemBuilder: (context, index) {
              return RejectedOppView(
                orgLogo: orgLogos[index],
                orgName: orgNames[index],
                oppName: oppNames[index],
                startDate: startDates[index],
                endDate: endDates[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
