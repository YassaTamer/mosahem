import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';
import 'package:mosahem/features/volunteer/home/presentation/views/filter_view_volunteer.dart';

class VolunteerHomeView extends StatefulWidget {
  const VolunteerHomeView({super.key, this.adminUserName = "Betty"});
  final String adminUserName;

  @override
  State<VolunteerHomeView> createState() => _VolunteerHomeViewState();
}

class _VolunteerHomeViewState extends State<VolunteerHomeView> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.mustardYellow, width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 38,
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/29885765/pexels-photo-29885765.jpeg',
                    ),
                  ),
                  // child: Image.asset(
                  //   AppAssets.girlProfilePhoto,
                  //   width: 100,
                  //   height: 100,
                  //   fit: BoxFit.fill,
                  // ),
                ),
              ),
            ),

            SizedBox(width: 10),

            CustomText(
              "Hi,Mario Nabil ...",
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: isSearching
                      ? Container(
                          width: 280,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            controller: searchController,
                            autofocus: true,
                            onSubmitted: (_) {
                              setState(() {
                                isSearching = false;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: AppColors.primary.withAlpha(
                                  (255 * 0.5).toInt(),
                                ),
                              ),
                              border: InputBorder.none,
                              prefixIcon: Image.asset(AppAssets.searchIcon),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    isSearching = false;
                                    searchController.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 280,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: CustomText(
                                  "Search",
                                  fontSize: 20,
                                  color: AppColors.primary.withAlpha(
                                    (255 * 0.5).toInt(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 170),
                              Image.asset(AppAssets.searchIcon),
                            ],
                          ),
                        ),
                ),

                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterViewVolunteer(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(AppAssets.filterIconDark),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                PostCard(
                  orgName: "Zad Solutions",
                  wantOrgPhoto: true,
                  orgPhoto: AppAssets.orgLogo,
                  timeAgo: "2h",
                  postImage: AppAssets.postImage,
                  title: "Green Future",
                  description:
                      "A humanitarian opportunity focused on visiting needy families, offering support, care, and basic assistance to bring hope and kindness to those in need",
                  location: "Cairo, Nasser City",
                  date: "10/12/2025",
                  time: "10:00 pm",
                  comments: "2.5K",
                  likes: "5K",
                ),
                SizedBox(height: 15),
                PostCard(
                  orgName: "Masr EL-kheir Foundation",
                  wantOrgPhoto: true,
                  orgPhoto: AppAssets.misrElKheirLogo,
                  timeAgo: "3h",
                  postImage: AppAssets.misrElKheirPostImage,
                  title: "Helping Hands",
                  description:
                      "A short opportunity about sustainable agriculture.",
                  location: "Al-Mansora",
                  date: "20/3/2026",
                  time: "4:00 pm",
                  comments: "1.2K",
                  likes: "3K",
                ),
                SizedBox(height: 15),
                PostCard(
                  orgName: "Icpc Sohag",
                  wantOrgPhoto: true,
                  orgPhoto: AppAssets.icpcLogo,
                  timeAgo: "1h",
                  postImage: AppAssets.icpcPostImage,
                  title: "Organizational Volunteering",
                  description:
                      "Short-term volunteer opportunity to help organize an event for the ICPC",
                  location: "Sohag, Creativa buliding",
                  date: "15/4/2026",
                  time: "8:00 am",
                  comments: "5.5K",
                  likes: "5K",
                ),
                SizedBox(height: 15),
                PostCard(
                  orgName: "Atfal Misr Foundation",
                  wantOrgPhoto: true,
                  orgPhoto: AppAssets.atfalMisrLogo,
                  timeAgo: "10h",
                  postImage: AppAssets.atfalMisrPostImage,
                  title: "Organizing Games",
                  description:
                      "Short-term volunteer opportunity to organize children's games",
                  location: "Cairo, Helioples",
                  date: "2/2/2026",
                  time: "12:00 pm",
                  comments: "4.2K",
                  likes: "2K",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
