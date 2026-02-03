import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/create_opp_view.dart';
//import 'package:mosahem/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setApplicationSwitcherDescription(
    const ApplicationSwitcherDescription(label: "Mosahem"),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: "Mosahem",
        debugShowCheckedModeBanner: false,
        home: CreateOppView(),
      ),
    );
  }
}
