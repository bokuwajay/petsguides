enum AppRoute {
  initialScreen(path: '/'),
  getStarted(path: '/get_started'),
  home(path: '/home'),
  map(path: '/map'),
  login(path: '/login');

  final String path;
  const AppRoute({required this.path});
}
