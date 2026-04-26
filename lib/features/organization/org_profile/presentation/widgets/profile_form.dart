import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Name"),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please enter you name";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(labelText: "Bio"),

            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please enter you name";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            decoration: const InputDecoration(
              labelText: "About us & Location & Tracks",
            ),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Please enter you name";
              }
              return null;
            },
          ),

          SizedBox(height: 100),
        ],
      ),
    );
  }
}
