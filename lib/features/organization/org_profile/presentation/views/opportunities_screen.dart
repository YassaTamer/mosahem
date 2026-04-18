import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/opportunities_header.dart';
import 'package:mosahem/features/organization/org_profile/presentation/widgets/post_card.dart';

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // الألوان اللي طلبتها بالظبط من الفيجما
  final List<Color> _tabColors = [
    const Color(0xFF4CAF50), // Active
    const Color(0xFF1B5E78), // History
    const Color(0xFFFFA000), // Pending
    const Color(0xFFF44336), // Rejected
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // تحديث الشاشة لما التاب يتغير عشان اللون يتحدث
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: SafeArea(
            child: OpportunitiesHeader(onTabChanged: (index) => print(index)),
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
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
            Center(child: Text("History Page")),
            Center(child: Text("Pending Page")),
            Center(child: Text("Rejected Page")),
          ],
        ),
      ),
    );
  }

  Widget _buildList(String status) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Center(child: Text("List for $status Content"));
      },
    );
  }
}
