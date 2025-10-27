import 'package:edunity/feature/auth/presentation/page/login/login_screen.dart';
import 'package:edunity/feature/auth/presentation/page/signup/register_screen.dart';
import 'package:edunity/feature/bookmark/presentation/pages/bookmark_screen.dart';
import 'package:edunity/feature/home/presentation/page/category_screen.dart';
import 'package:edunity/feature/home/presentation/page/filter_screen.dart';
import 'package:edunity/feature/home/presentation/page/home_screen.dart';
import 'package:edunity/feature/home/presentation/page/search_screen.dart';
import 'package:edunity/feature/home/presentation/page/top_mentor_screen.dart';
import 'package:edunity/feature/main/main_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/my_courses_page.dart';
import 'package:edunity/feature/notification/presentation/pages/notifications.dart';
import 'package:edunity/feature/onboarding/page/welcome_screen.dart';
import 'package:edunity/feature/profile/presentation/page/edit_profile.dart';
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
  static const String notifications = '/notifications';
  static const String mainprofile = '/profile';
  static const String myCourses = '/myCourses';
  static const String editProfile = '/editProfile';
  static const String bookmark = '/bookmark';
  static const String topMentors = '/topMentors';
  static const String filter = '/filter';

  static final routes = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(path: login, builder: (context, state) => LoginScreen()),
      GoRoute(path: register, builder: (context, state) => RegisterScreen()),
      GoRoute(path: main, builder: (context, state) => MainScreen()),
      GoRoute(path: home, builder: (context, state) => HomeScreen()),
      GoRoute(path: category, builder: (context, state) => CategoryScreen()),
      GoRoute(path: search, builder: (context, state) => SearchScreen()),
      GoRoute(
          path: notifications,
          builder: (context, state) => NotificationScreen()),
      GoRoute(path: mainprofile, builder: (context, state) => ProfileScreen()),
      GoRoute(
          path: topMentors, builder: (context, state) => TopMentorsScreen()),
      GoRoute(path: filter, builder: (context, state) => FilterScreen()),
      GoRoute(path: myCourses, builder: (context, state) => MyCourses()),
      GoRoute(path: editProfile, builder: (context, state) => EditProfile()),
      GoRoute(path: bookmark, builder: (context, state) => BookmarkScreen()),
    ],
  );
}
