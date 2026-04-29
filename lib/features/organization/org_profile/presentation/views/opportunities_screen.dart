import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_cubit.dart';
import 'package:mosahem/features/organization/org_profile/logic/cubit/org_profile_state.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/opportunities_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';

class OpportunitiesScreen extends StatefulWidget {
  final String organizationId;
  final String organizationLogo;

  const OpportunitiesScreen({
    super.key,
    required this.organizationId,
    required this.organizationLogo,
  });
  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    final cubit = context.read<OrgProfileCubit>();

    // أول تحميل → Active
    cubit.getOpportunities(
      organizationId: widget.organizationId,
      status: "Active",
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
        setState(() {}); // 👈 مهم
      }
    });
  }

  void _onTabChanged(int index) {
    final cubit = context.read<OrgProfileCubit>();

    String status;

    switch (index) {
      case 0:
        status = "Active";
        break;
      case 1:
        status = "Ended";
        break;
      default:
        return; // باقي التابات مش شغالة
    }

    cubit.getOpportunities(
      organizationId: widget.organizationId,
      status: status,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrgProfileCubit>();

    String currentStatus = _tabController.index == 0 ? "Active" : "Ended";

    final count = cubit.opportunitiesFor(currentStatus).length;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SafeArea(
          child: OpportunitiesHeader(
            controller: _tabController,
            opportunitiesCount: count,
          ),
        ),
      ),
      body: BlocBuilder<OrgProfileCubit, OrgProfileState>(
        buildWhen: (previous, current) => current is OrgOpportunitiesState,
        builder: (context, _) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildOpportunityTab("Active"),
              _buildOpportunityTab("Ended"),
              const Center(child: Text("Pending Page")),
              const Center(child: Text("Rejected Page")),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOpportunityTab(String status) {
    final cubit = context.read<OrgProfileCubit>();
    final items = cubit.opportunitiesFor(status);
    final isLoading = cubit.isLoadingOpportunities(status);
    final hasLoaded = cubit.hasLoadedOpportunities(status);

    if (isLoading && !hasLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return const Center(child: Text("No Opportunities"));
    }

    return _buildList(items);
  }

  Widget _buildList(List<OpportunityModel> items) {
    final org = context.read<OrgProfileCubit>().orgData;
    final organizationLocation = (org?.locations.isNotEmpty ?? false)
        ? org!.locations.first.cityName
        : '';

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final opportunity = items[index];

        return PostCard(
          wantOrgPhoto: true,
          orgLogo:
              widget.organizationLogo, //  orgLogo: opportunity.logoUrl ?? '',
          orgName: opportunity.organizationName,
          timeAgo: opportunity.startDate,
          postImage: opportunity.opportunityPhotoUrl ?? AppAssets.postImage,
          title: opportunity.name,
          description: org?.organizationDescription ?? '',
          location: organizationLocation,
          date: opportunity.startDate,
          time: opportunity.endDate,
          comments: '0',
          likes: '0',
        );
      },
    );
  }
}
