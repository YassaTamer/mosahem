import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/date_helper.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/logic/volunteer_profile_cubit.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/logic/volunteer_profile_state.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/views/setting_screen_vol.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/infobox.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/section_card.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/tagitem_.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late VolunteerProfileCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<VolunteerProfileCubit>();

    cubit.getVolunteerProfile("f9120146-6801-408b-a222-d107ec4baa7c");
  }

  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<VolunteerProfileCubit, VolunteerProfileState>(
        builder: (context, state) {
          if (state is VolunteerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is VolunteerProfileError) {
            return Center(child: Text(state.message));
          }

          if (state is VolunteerProfileSuccess) {
            final profile = state.profile;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentGeometry.center,
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(profile.coverPhoto ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingScreenVol(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.more_vert,
                            size: 40,
                            color: AppColors.primary,
                          ),
                          alignment: Alignment.topRight,
                        ),
                      ),
                      Positioned(
                        bottom: -50,
                        left: 30,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 56,
                            backgroundImage: NetworkImage(
                              profile.profilePhoto ?? "",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      profile.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Image.asset(
                          (AppAssets.phoneIcon),
                          height: 15,
                          width: 15,
                        ),
                        Text(
                          ' ${profile.phone ?? ""}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Image.asset(
                          (AppAssets.locationIcon2),
                          height: 15,
                          width: 15,
                        ),
                        Text(
                          ' ${profile.location ?? ""}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SectionCard(
                    title: 'Bio',
                    isVolunteer: true,
                    child: Text(profile.bio ?? ""),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InfoBox(
                            icon: Icons.person_outline,
                            title: "Gender",
                            value: profile.gender ?? "",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InfoBox(
                            icon: Icons.calendar_today,
                            title: "Date of Birth",
                            value: DateHelper.formatNumeric(
                              profile.dateOfBirth ?? "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InfoBox(
                            icon: Icons.access_time,
                            title: "Total Hours",
                            value: profile.totalHours.toString(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InfoBox(
                            icon: Icons.emoji_events_outlined,
                            title: "Completed Ops",
                            value: profile.completedCount.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SectionCard(
                    title: "Skills",
                    isVolunteer: true,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(profile.skills.length, (index) {
                        final skill = profile.skills[index];
                        return TagItem(
                          label: skill.name,
                          color: colors[index % colors.length],
                        );
                      }),
                    ),
                  ),
                  SectionCard(
                    title: "Fields of Interest",
                    isVolunteer: true,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(profile.fields.length, (index) {
                        final field = profile.fields[index];
                        return TagItem(
                          label: field.name,
                          color: colors[index % colors.length],
                        );
                      }),
                    ),
                  ),
                  SectionCard(
                    title: 'Completed Opportunities',
                    isVolunteer: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profile.completedOpportunities.length,
                      itemBuilder: (context, index) {
                        final opp = profile.completedOpportunities[index];
                        return PostCard(
                          workType: opp.workType ?? "On-Site",
                          timeType: opp.timeType ?? "Part Time",
                          status: opp.status ?? "Closed",
                          wantOrgPhoto: true,
                          orgLogo: opp.logoUrl,
                          applyButton: false,
                          orgName: opp.organizationName,
                          timeAgo: opp.createdAt ?? "",
                          postImage: opp.opportunityPhotoUrl ?? "",
                          title: opp.name,
                          description: opp.description ?? "",
                          location: opp.location ?? "",
                          date: DateHelper.formatNumeric(opp.startDate),
                          time: opp.endDate,
                          comments: "0",
                          likes: "0",
                        );
                      },
                    ),
                  ),
                  // SectionCard(
                  //   title: ' Saved Opportunities',
                  //   isVolunteer: true,
                  //   child: PostCard(
                  //     orgName: 'orgName',
                  //     timeAgo: '[timeAgo]',
                  //     postImage: AppAssets.postImage,
                  //     title: 'title',
                  //     description: 'description',
                  //     location: 'location',
                  //     date: 'date',
                  //     time: 'time',
                  //     comments: '5',
                  //     likes: '5',
                  //   ),
                  // ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
