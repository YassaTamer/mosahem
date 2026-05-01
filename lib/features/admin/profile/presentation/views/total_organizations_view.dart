import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/organization_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/organization_state.dart';
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
    context.read<OrganizationCubit>().getOrganizations(); // 🔥 دي أهم سطر

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
  List<dynamic> acceptedOrgs = [];
  bool isInitialized = false;
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

      body: BlocBuilder<OrganizationCubit, OrganizationState>(
        builder: (context, state) {
          if (state is OrganizationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrganizationError) {
            return Center(child: Text(state.message));
          }

          if (state is OrganizationSuccess) {
            if (!isInitialized) {
              acceptedOrgs = state.organizations
                  .where((e) => e.status == 'Approved')
                  .toList();
              isInitialized = true;
            }
            final orgs = state.organizations;
            final accepted = orgs.where((e) => e.status == 'Approved').toList();

            final rejected = orgs.where((e) => e.status == 'Rejected').toList();
            return TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: acceptedOrgs.length,
                  itemBuilder: (context, index) {
                    final org = acceptedOrgs[index];
                    return AcceptedOrgView(
                      orgLogo: (org.logo != null && org.logo!.isNotEmpty)
                          ? org.logo!
                          : AppAssets.orgLogo,
                      // onDelete: () {
                      //   setState(() {
                      //     orgLogos.removeAt(index);
                      //     orgNames.removeAt(index);
                      //   });
                      // },
                      //  orgLogo: AppAssets.orgLogo,
                      orgName: org.name,
                      onDelete: () {
                        setState(() {
                          acceptedOrgs.removeAt(index);
                        });
                      },
                    );
                  },
                ),
                ListView.builder(
                  itemCount: rejected.length,
                  itemBuilder: (context, index) {
                    final org = rejected[index];

                    return RejectedOrgView(
                      orgLogo: (org.logo != null && org.logo!.isNotEmpty)
                          ? org.logo!
                          : AppAssets.orgLogo,
                      orgName: org.name,
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
