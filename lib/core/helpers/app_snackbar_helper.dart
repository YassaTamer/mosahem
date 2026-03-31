import 'package:flutter/material.dart';
import '../widgets/app_snackbar.dart';

class AppSnackBarHelper {
  /// 🔴 ERROR
  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      color: const Color(0xffE53935),
      icon: Icons.error_rounded,
    );
  }

  /// 🟢 SUCCESS
  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      color: Colors.green,
      icon: Icons.check_circle_rounded,
    );
  }

  /// 🟠 WARNING
  static void warning(BuildContext context, String message) {
    _show(
      context,
      message: message,
      color: Colors.orange,
      icon: Icons.warning_rounded,
    );
  }

  /// 🧠 CORE FUNCTION
  static void _show(
    BuildContext context, {
    required String message,
    required Color color,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      content: AppSnackBar(message: message, color: color, icon: icon),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
