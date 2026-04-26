import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/about_description.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/location_section_about.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/tracks_section_about.dart';

class ProfileOrgContent extends StatelessWidget {
  const ProfileOrgContent({super.key});
  @override
  Widget build(BuildContext context) {
    /// بيانات البوستات
    final List<Map<String, String>> activePosts = [
      {
        "orgName": "Zad Solutions",
        "timeAgo": "2h",
        "image": AppAssets.postImage,
        "title": "Green Future",
        "description":
            "A humanitarian opportunity focused on visiting needy families.",
        "location": "Cairo, Nasser city",
        "date": "10/12/2025",
        "time": "10:00 PM",
        "comments": "2.5k",
        "likes": "5k",
      },

      {
        "orgName": "Zad Solutions",
        "timeAgo": "3h",
        "image": AppAssets.postImage,
        "title": "Helping Hands",
        "description": "A short opportunity about sustainable agriculture.",
        "location": "Cairo, Nasser city",
        "date": "10/12/2025",
        "time": "4:00 PM",
        "comments": "1.2k",
        "likes": "3k",
      },
    ];

    final List<Map<String, String>> historyPosts = [
      {
        "orgName": "Zad Solutions",
        "timeAgo": "3 day",
        "image": AppAssets.postImage,
        "title": "Helping Hands",
        "description": "A short opportunity about sustainable agriculture.",
        "location": "Cairo, Nasser city",
        "date": "10/12/2025",
        "time": "4:00 PM",
        "comments": "2.5k",
        "likes": "5k",
      },
    ];

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Active"),
              Tab(text: "History"),
              Tab(text: "About"),
            ],
          ),

          Expanded(
            child: TabBarView(
              children: [
                /// ACTIVE TAB
                ListView.separated(
                  itemCount: activePosts.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final post = activePosts[index];

                    return PostCard(
                      orgName: post["orgName"]!,
                      timeAgo: post["timeAgo"]!,
                      postImage: post["image"]!,
                      title: post["title"]!,
                      description: post["description"]!,
                      location: post["location"]!,
                      date: post["date"]!,
                      time: post["time"]!,
                      comments: post["comments"]!,
                      likes: post["likes"]!,
                    );
                  },
                ),

                /// HISTORY TAB
                ListView.builder(
                  itemCount: historyPosts.length,
                  itemBuilder: (context, index) {
                    final post = historyPosts[index];

                    return PostCard(
                      orgName: post["orgName"]!,
                      timeAgo: post["timeAgo"]!,
                      postImage: post["image"]!,
                      title: post["title"]!,
                      description: post["description"]!,
                      location: post["location"]!,
                      date: post["date"]!,
                      time: post["time"]!,
                      comments: post["comments"]!,
                      likes: post["likes"]!,
                    );
                  },
                ),

                /// ABOUT
                const Center(
                  child: SingleChildScrollView(
                    padding:  EdgeInsets.all(8),
                    child: Column(
                      children: [
                         AboutDescriptionSection(
                          description: "Mosahem is a volunteering platform...",
                          vision: "We believe that everyone has the ability...",
                        ),
                         Divider(height: 40),
                        LocationsSection(
                          showAddIcon: false,
                          showDeleteIcon: false,
                          showEditIcon: false,
                        ),

                         Divider(height: 40),

                         TracksSection(
                          showAddIcon: false,
                          showRemoveIcon: false,
                        ),

                         SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
