import 'package:flutter_boilerplate/src/core/router/app_route.dart';
import 'package:flutter_boilerplate/src/core/widget/widget.dart';
import 'package:flutter_boilerplate/src/presentation/page/page.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: AppRoute.home.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(
        currentPath: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: AppRoute.home.path,
          name: AppRoute.home.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: AppRoute.settings.path,
          name: AppRoute.settings.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsPage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.detail.path,
      name: AppRoute.detail.name,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';

        return DetailPage(id: id);
      },
    ),
  ],
);
