import 'package:flutter/material.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/create_opp_view.dart';
//import 'package:mosahem/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateOppView(),
=======
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SplashView()),
>>>>>>> a38811f22243b910c2edd3f97018856adc150501
    );
  }
}
