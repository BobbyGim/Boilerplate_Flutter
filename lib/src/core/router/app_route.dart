enum AppRoute {
  home(name: 'home', path: '/'),
  settings(name: 'settings', path: '/settings'),
  detail(name: 'detail', path: '/detail/:id');

  const AppRoute({required this.name, required this.path});

  final String name;
  final String path;
}
