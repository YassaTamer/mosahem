import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/app_snackbar_helper.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';
import 'package:mosahem/features/organization/opportunity_details/presentation/views/application_questions_screen.dart';

class OpportunityDetailsScreen extends StatefulWidget {
  const OpportunityDetailsScreen({
    super.key,
    required this.opportunityId,
    this.isOrganization = false,
  });

  final String opportunityId;
  final bool isOrganization;

  @override
  State<OpportunityDetailsScreen> createState() =>
      _OpportunityDetailsScreenState();
}

class _OpportunityDetailsScreenState extends State<OpportunityDetailsScreen> {
  void _handleApplyPressed() {
    final cubit = context.read<OpportunityCubit>();
    final opp = cubit.selectedOpportunity;

    if (opp == null) return;

    final questions = opp.questions ?? [];
    if (questions.isEmpty) {
      _applyDirectly(opp.id);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicationQuestionsScreen(
          questions: questions,
          opportunityId: opp.id,
        ),
      ),
    );
  }

  // void _applyDirectly(String opportunityId) {
  //   AppSnackBarHelper.success(context, 'Applied successfully');
  // }
  void _applyDirectly(String opportunityId) {
    context.read<OpportunityCubit>().applyToOpportunity(opportunityId);
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<OpportunityCubit>();

    if (cubit.selectedOpportunity?.id != widget.opportunityId) {
      cubit.getOpportunityDetails(widget.opportunityId);
    } else {
      final current = cubit.selectedOpportunity!;
      cubit.emit(OpportunityDetailsLoaded(current, cubit.currentOpportunities));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OpportunityCubit, OpportunityState>(
      listener: (context, state) {
        if (state is OpportunityApplySuccess) {
          AppSnackBarHelper.success(context, state.message);
        }

        if (state is OpportunityError) {
          AppSnackBarHelper.error(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        bottomNavigationBar: widget.isOrganization
            ? null
            : BlocBuilder<OpportunityCubit, OpportunityState>(
                builder: (context, state) {
                  final cubit = context.read<OpportunityCubit>();
                  final opp = cubit.selectedOpportunity;
                  final hasQuestions = (opp?.questions?.isNotEmpty ?? false);
                  final isApplied =
                      cubit.selectedOpportunity?.isApplied ?? false;
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed:
                              (state is OpportunityApplyLoading || isApplied)
                              ? null
                              : _handleApplyPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: state is OpportunityApplyLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  isApplied
                                      ? 'Applied ✅'
                                      : (hasQuestions
                                            ? 'Continue to Apply'
                                            : 'Apply'),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),

        body: BlocBuilder<OpportunityCubit, OpportunityState>(
          builder: (context, state) {
            if (state is OpportunityLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is OpportunityError) {
              return Center(child: Text(state.message));
            }

            final cubit = context.read<OpportunityCubit>();
            final opp = cubit.selectedOpportunity;

            if (opp == null) {
              return const SizedBox();
            }

            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, opp.opportunityPhotoUrl),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(opp.name),
                        const SizedBox(height: 8),
                        _buildOrgRow(opp.organizationName, opp.logoUrl),
                        const SizedBox(height: 16),
                        _buildVolunteerStatsCard(opp),
                        const SizedBox(height: 16),
                        _buildVolunteerFieldCard(),
                        const SizedBox(height: 20),
                        _buildAboutSection(opp.description ?? ""),
                        const SizedBox(height: 20),
                        _buildKeyDetailsSection(opp),
                        const SizedBox(height: 20),
                        _buildSkillsMustHaveSection(opp.requiredSkills),
                        const SizedBox(height: 20),
                        _buildSkillsWillAcquireSection(opp.providedSkills),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, String? imageUrl) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.white,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primary,
            size: 18,
          ),
        ),
      ),

      // actions: !widget.isOrganization
      //     ? null
      //     : [
      //         Container(
      //           margin: const EdgeInsets.all(8),
      //           decoration: BoxDecoration(
      //             color: AppColors.white.withOpacity(0.9),
      //             shape: BoxShape.circle,
      //           ),
      //           child: IconButton(
      //             icon: const Icon(
      //               Icons.edit_outlined,
      //               color: AppColors.primary,
      //               size: 20,
      //             ),
      //             onPressed: () {},
      //           ),
      //         ),
      //       ], // volunteers see no action icon
      title: const Text(
        'Opportunity Details',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl ?? "",
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: AppColors.primaryLightBlue,
                child: const Icon(Icons.image),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Content sections ──────────────────────────────────────────────────────
  Widget _buildTitleSection(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 6),
        const Text('🌱', style: TextStyle(fontSize: 24)),
      ],
    );
  }

  Widget _buildOrgRow(String name, String? logo) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: (logo != null && logo.isNotEmpty)
              ? NetworkImage(logo)
              : null,
          child: (logo == null || logo.isEmpty)
              ? const Icon(Icons.business)
              : null,
        ),
        const SizedBox(width: 8),
        Text(name),
      ],
    );
  }

  Widget _buildVolunteerStatsCard(OpportunityModel opp) {
    final total = opp.numberOfVolunteers ?? 0;
    final joined = opp.applicantsCount ?? 0;

    final recent = opp.pendingApplicantsCount ?? 0;
    final accepted = opp.acceptedApplicantsCount ?? 0;
    final rejected = opp.rejectedApplicantsCount ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.people_outline,
                color: AppColors.primary,
                size: 22,
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$joined',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textBlueDark,
                      ),
                    ),
                    TextSpan(
                      text: '/$total volunteers joined',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : joined / total,
              minHeight: 8,
              backgroundColor: AppColors.greyLight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Recent', '$recent', AppColors.mustardYellow),
              Container(width: 1, height: 36, color: AppColors.greyLight),
              _buildStatItem('Accepted', '$accepted', AppColors.lightGreen),
              Container(width: 1, height: 36, color: AppColors.greyLight),
              _buildStatItem('Rejected', '$rejected', AppColors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildVolunteerFieldCard() {
    final fields = [
      'Arts & Culture',
      'Community Service',
      'Environment',
      'Healthcare',
      'Child Care',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textBlueDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('🧩', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                'Volunteer field',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: fields.map(_buildFieldChip).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAboutSection(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About This Opportunity'),
        const SizedBox(height: 12),
        Text(description),
      ],
    );
  }

  Widget _buildKeyDetailsSection(OpportunityModel opp) {
    final location = opp.location ?? "Unknown";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Key Details'),
        const SizedBox(height: 12),

        _buildDetailCard(
          icon: Icons.location_on_outlined,
          iconColor: AppColors.mustardYellow,
          title: 'Location',
          content: location,
        ),

        const SizedBox(height: 10),

        _buildDetailCard(
          icon: Icons.calendar_today_outlined,
          iconColor: AppColors.primary,
          title: 'Duration',
          content:
              "${DateHelper.formatNumeric(opp.startDate)} → ${DateHelper.formatNumeric(opp.endDate)}",
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _buildDetailCard(
                icon: Icons.work_outline,
                iconColor: AppColors.mustardYellow,
                title: 'Work Type',
                content: opp.workType ?? "Unknown",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDetailCard(
                icon: Icons.location_city_outlined,
                iconColor: AppColors.primary,
                title: 'Work Location',
                content: opp.timeType ?? "Unknown",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsMustHaveSection(List? skills) {
    if (skills == null || skills.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🏆 Skills You Must Have'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: skills.map((s) => _buildCheckChip(s.name)).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyLight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textBlueDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsWillAcquireSection(List? skills) {
    if (skills == null || skills.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🎯 Skills You Will Acquire'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: skills.map((s) => _buildAcquireChip(s.name)).toList(),
        ),
      ],
    );
  }

  Widget _buildAcquireChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyLight),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textBlueDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlueDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
