import 'package:flutter/material.dart';

class AppNavigationDestination extends NavigationDestination {
  AppNavigationDestination({
    required IconData icon,
    required IconData selectedIcon,
    required super.label,
    super.key,
  }) : super(
          icon: Icon(icon),
          selectedIcon: Icon(selectedIcon),
        );
}
