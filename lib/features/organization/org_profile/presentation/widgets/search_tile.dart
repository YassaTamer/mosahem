import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onDelete;

  const SearchTile({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close, color: Colors.grey, size: 20),
        onPressed: onDelete,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
