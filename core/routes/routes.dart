import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/';

  static final routes = GoRouter(
    routes: [
      // GoRoute(path: splash, builder: (context, state) => SplashScreen()),
    ],
  );
}
