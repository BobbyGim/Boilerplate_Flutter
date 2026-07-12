import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/src/core/router/router.dart';
import 'package:flutter_boilerplate/src/core/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter, theme: AppTheme.light);
  }
}
