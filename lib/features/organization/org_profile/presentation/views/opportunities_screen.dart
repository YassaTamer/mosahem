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

    cubit.getOpportunities(
      organizationId: widget.organizationId,
      status: "Active",
    );

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
        setState(() {});
      }
    });
  }

  void _onTabChanged(int index) {
    final cubit = context.read<OrgProfileCubit>();

    switch (index) {
      case 0:
        cubit.getOpportunities(
          organizationId: widget.organizationId,
          status: "Active",
        );
        break;
      case 1:
        cubit.getOpportunities(
          organizationId: widget.organizationId,
          status: "Ended",
        );
        break;
      case 2:
        cubit.getOpportunitiesByVerificationStatus(
          organizationId: widget.organizationId,
          status: "Pending",
        );
        break;
      case 3:
        cubit.getOpportunitiesByVerificationStatus(
          organizationId: widget.organizationId,
          status: "Rejected",
        );
        break;
      default:
        return;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OrgProfileCubit>();

    final currentStatus = switch (_tabController.index) {
      0 => "Active",
      1 => "Ended",
      2 => "Pending",
      3 => "Rejected",
      _ => "Active",
    };

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
              _buildOpportunityTab("Pending"),
              _buildOpportunityTab("Rejected"),
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
          orgLogo: widget.organizationLogo,
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
