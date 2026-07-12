import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/src/core/router/app_route.dart';
import 'package:flutter_boilerplate/src/core/widget/app_navigation_destination.dart';
import 'package:go_router/go_router.dart';

typedef AppShellModel = ({
  int currentIndex,
  List<NavigationDestination> destinations,
  ValueChanged<int> goDestination,
});

AppShellModel useAppShell({
  required BuildContext context,
  required String currentPath,
}) {
  final routes = [AppRoute.home, AppRoute.settings];
  final paths = routes.map((route) => route.path).toList();

  final currentIndex = paths.indexOf(currentPath);

  void goDestination(int index) {
    HapticFeedback.selectionClick();
    context.go(paths[index]);
  }

  return (
    currentIndex: currentIndex < 0 ? 0 : currentIndex,
    destinations: [
      AppNavigationDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: '홈',
      ),
      AppNavigationDestination(
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
        label: '세팅',
      ),
    ],
    goDestination: goDestination,
  );
}
