import 'package:flutter/material.dart';

class LikesBottomSheet extends StatelessWidget {
  const LikesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),

                    const Text(
                      "Likes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFD4AF37),
                      ),
                    ),

                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),

              /// LIKES LIST
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return _buildLikeItem();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLikeItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          /// USER IMAGE
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/men/45.jpg",
            ),
          ),

          const SizedBox(width: 12),

          /// NAME + TIME
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wade Warren",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),

                SizedBox(height: 2),

                Text("2m", style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),

          /// HEART ICON
          const Icon(Icons.favorite, color: Colors.red, size: 20),
        ],
      ),
    );
  }
}
