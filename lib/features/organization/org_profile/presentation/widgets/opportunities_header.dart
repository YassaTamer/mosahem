import 'package:flutter/material.dart';

class OpportunitiesHeader extends StatelessWidget {
  final int opportunitiesCount;
  final Function(int) onTabChanged;

  const OpportunitiesHeader({
    super.key,
    this.opportunitiesCount = 800,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(flex: 2),
                const Text(
                  "Opportunities",
                  style: TextStyle(
                    color: Color(0xFF1B5E78),
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  opportunitiesCount.toString(),
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(flex: 3),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey, size: 26),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const TabBar(
            isScrollable: false,
            labelColor: Color(0xFF4CAF50),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF4CAF50),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              Tab(text: "Active"),
              Tab(text: "History"),
              Tab(text: "Pending"),
              Tab(text: "Rejected"),
            ],
          ),
        ],
      ),
    );
  }
}
