import 'package:go_router/go_router.dart';
import 'package:petsguides/views/google_map.dart';
import 'package:petsguides/views/home_view.dart';
import 'package:petsguides/views/login_view.dart';

// Function to initialize and configure the GoRouter
GoRouter initRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/goMap',
        builder: (context, state) => const GoogleMapView(),
      ),
    ],
  );
}

// Export the initialized router
final GoRouter router = initRouter();
