import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/widget/hooks/hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppShell extends HookWidget {
  const AppShell({required this.currentPath, required this.child, super.key});

  final String currentPath;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final (:currentIndex, :destinations, :goDestination) = useAppShell(
      context: context,
      currentPath: currentPath,
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        child: NavigationBar(
          animationDuration: Duration.zero,
          indicatorColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          selectedIndex: currentIndex,
          onDestinationSelected: goDestination,
          destinations: destinations,
        ),
      ),
    );
  }
}
