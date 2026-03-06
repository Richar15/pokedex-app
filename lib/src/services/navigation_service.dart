import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<void> navigateTo(String route) async {
    await navigatorKey.currentState!.pushNamed(route);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }
}