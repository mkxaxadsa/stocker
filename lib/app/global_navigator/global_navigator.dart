import 'package:flutter/material.dart';

class GlobalNavigator {
  static Future<T?> push<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
      (route) => false,
    );
  }

  static Future<T?> pushReplacement<T extends Object?>(BuildContext context,
      {required Widget page}) {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
      ),
    );
  }
}