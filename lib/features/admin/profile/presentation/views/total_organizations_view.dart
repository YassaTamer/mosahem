import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/presentation/views/accepted_org_view.dart';
import 'package:mosahem/features/admin/profile/presentation/views/rejected_org_view.dart';

class TotalOrganizationsView extends StatefulWidget {
  const TotalOrganizationsView({super.key});

  @override
  State<TotalOrganizationsView> createState() => _TotalOrganizationsViewState();
}

class _TotalOrganizationsViewState extends State<TotalOrganizationsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

  Color indicatorColor = Colors.green;
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
                'Total Organizations',
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
            itemCount: orgNames.length,
            itemBuilder: (context, index) {
              return AcceptedOrgView(
                orgLogo: orgLogos[index],
                orgName: orgNames[index],
                onDelete: () {
                  setState(() {
                    orgLogos.removeAt(index);
                    orgNames.removeAt(index);
                  });
                },
              );
            },
          ),
          ListView.builder(
            itemCount: orgNames.length,
            itemBuilder: (context, index) {
              return RejectedOrgView(
                orgLogo: orgLogos[index],
                orgName: orgNames[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
