import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/views/setting_screen_vol.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/infobox.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/section_card.dart';
import 'package:mosahem/features/volunteer/volunteer_profile/presentation/widgets/tagitem_.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                      image: NetworkImage(
                        'https://images.pexels.com/photos/33402021/pexels-photo-33402021.jpeg',
                      ),
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
                      radius: 55,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/29885765/pexels-photo-29885765.jpeg',
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
                'Mario Nabil',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Image.asset((AppAssets.phoneIcon), height: 15, width: 15),
                  Text(' 01205718228', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Image.asset((AppAssets.locationIcon2), height: 15, width: 15),
                  Text(' Sohag - Elkarnak ', style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
            SizedBox(height: 10),
            SectionCard(
              title: 'Bio',
              isVolunteer: true,
              child: Text(
                'Passionate about environmental conservation and community development. Dedicated to making a positive impact through volunteering.',
              ),
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
                      value: "Male",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InfoBox(
                      icon: Icons.calendar_today,
                      title: "Date of Birth",
                      value: "15/5/1995",
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
                      value: "342",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InfoBox(
                      icon: Icons.emoji_events_outlined,
                      title: "Completed Ops",
                      value: "28",
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
                children: [
                  TagItem(label: "Project Management", color: Colors.blue),
                  TagItem(label: "Communication", color: Colors.green),
                  TagItem(label: "Teamwork", color: Colors.orange),
                  TagItem(label: "Leadership", color: Colors.purple),
                ],
              ),
            ),
            SectionCard(
              title: "Fields of Interest",
              isVolunteer: true,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TagItem(
                    label: "Environmental Conservation",
                    color: Colors.teal,
                  ),
                  TagItem(label: "Digital Design", color: Colors.orange),
                  TagItem(label: "Community Development", color: Colors.indigo),
                  TagItem(label: "Education", color: Colors.deepPurple),
                ],
              ),
            ),
            SectionCard(
              title: 'Completed Opportunities',
              isVolunteer: true,
              child: PostCard(
                orgName: 'orgName',
                timeAgo: '[timeAgo]',
                postImage: AppAssets.postImage,
                title: 'title',
                description: 'description',
                location: 'location',
                date: 'date',
                time: 'time',
                comments: '5',
                likes: '5',
              ),
            ),
            SectionCard(
              title: ' Saved Opportunities',
              isVolunteer: true,
              child: PostCard(
                orgName: 'orgName',
                timeAgo: '[timeAgo]',
                postImage: AppAssets.postImage,
                title: 'title',
                description: 'description',
                location: 'location',
                date: 'date',
                time: 'time',
                comments: '5',
                likes: '5',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
