import 'package:flutter/material.dart';
import 'package:mosahem/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MyApp());
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
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SplashView()),
    );
  }
}
