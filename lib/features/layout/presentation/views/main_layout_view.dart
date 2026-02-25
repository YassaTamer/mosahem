import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/user_role.dart';

class MainLayoutView extends StatefulWidget {
  final UserRole role;

  const MainLayoutView({super.key, required this.role});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Layout - ${widget.role.name}')),
      body: Center(
        child: Text(
          'You are logged in as ${widget.role.name}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
