import 'package:edunity/feature/auth/presentation/page/login_screen.dart';
import 'package:edunity/feature/auth/presentation/page/register_screen.dart';
import 'package:edunity/feature/home/presentation/page/category_screen.dart';
import 'package:edunity/feature/home/presentation/page/search_screen.dart';
import 'package:edunity/feature/main/main_screen.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:edunity/feature/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String category = '/category';
  static const String search = '/search';
  static const String profile = '/profile';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: login, builder: (context, state) => LoginScreen()),
      GoRoute(path: register, builder: (context, state) => RegisterScreen()),
      GoRoute(path: main, builder: (context, state) => MainScreen()),
      GoRoute(path: home, builder: (context, state) => LoginScreen()),
      GoRoute(path: category, builder: (context, state) => CategoryScreen()),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
      GoRoute(path: profile, builder: (context, state) => ProfileScreen()),
    ],
  );
}
