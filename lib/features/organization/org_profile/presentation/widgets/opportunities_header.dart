import 'package:flutter/material.dart';

class OpportunitiesHeader extends StatelessWidget {
  final int opportunitiesCount;
  final TabController controller;
  const OpportunitiesHeader({
    super.key,
    this.opportunitiesCount = 6,
    required this.controller,
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
                // IconButton(
                //   icon: const Icon(Icons.search, color: Colors.grey, size: 26),
                //   onPressed: () {},
                // ),
              ],
            ),
          ),

          TabBar(
            controller: controller,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Color(0xFF4CAF50),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF4CAF50),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
