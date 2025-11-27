// Import necessary packages and screens for routing.
import 'package:edunity/core/model/chat_model.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:edunity/feature/auth/presentation/page/login/login_screen.dart';
import 'package:edunity/feature/auth/presentation/page/signup/register_screen.dart';
import 'package:edunity/feature/bookmark/presentation/pages/bookmark_screen.dart';
import 'package:edunity/feature/categories/category_screen.dart';
import 'package:edunity/feature/chat/page/chat_screen.dart';
import 'package:edunity/feature/home/presentation/page/home_screen.dart';
import 'package:edunity/feature/main/main_screen.dart';
import 'package:edunity/feature/mentors/page/top_mentor_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/my_courses_page.dart';
import 'package:edunity/feature/notification/presentation/pages/notifications.dart';
import 'package:edunity/feature/onboarding/page/welcome_screen.dart';
import 'package:edunity/feature/profile/presentation/page/edit_profile.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:edunity/feature/search/filter_screen.dart';
import 'package:edunity/feature/search/search_screen.dart';
import 'package:edunity/feature/splash/splash_screen.dart';
import 'package:edunity/feature/teacher/teacher_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// This class defines the routes for the application.
class Routes {
  // Define route constants for easy access and to avoid typos.
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
  static const String chatScreen = '/chat';
  static const String teacherHome = '/teacherHome';

  // The GoRouter configuration for the application.
  static final routes = GoRouter(
    routes: [
      // The splash screen is the initial route of the application.
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),

      // The welcome screen is shown after the splash screen.
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),

      // The login screen, with the AuthBloc provided to its widget tree.
      GoRoute(
          path: login,
          builder: (context, state) => BlocProvider(
                create: (context) => AuthBloc(),
                child: LoginScreen(),
              )),

      // The register screen, also with the AuthBloc.
      GoRoute(
          path: register,
          builder: (context, state) => BlocProvider(
                create: (context) => AuthBloc(),
                child: RegisterScreen(),
              )),

      // The main screen of the application.
      GoRoute(path: main, builder: (context, state) => MainScreen()),

      // The home screen.
      GoRoute(path: home, builder: (context, state) => HomeScreen()),

      // The category screen.
      GoRoute(path: category, builder: (context, state) => CategoryScreen()),

      // The search screen.
      GoRoute(path: search, builder: (context, state) => SearchScreen()),

      // The notifications screen.
      GoRoute(
          path: notifications,
          builder: (context, state) => NotificationScreen()),

      // The user's profile screen.
      GoRoute(path: mainprofile, builder: (context, state) => ProfileScreen()),

      // The screen for the user's enrolled courses.
      GoRoute(
          path: topMentors, builder: (context, state) => TopMentorsScreen()),

      // The filter screen for searching.
      GoRoute(path: filter, builder: (context, state) => FilterScreen()),

      // The screen for the user's enrolled courses.
      GoRoute(path: myCourses, builder: (context, state) => MyCourses()),

      // The screen for editing the user's profile.
      GoRoute(path: editProfile, builder: (context, state) => EditProfile()),

      // The screen for the user's bookmarked courses.
      GoRoute(path: bookmark, builder: (context, state) => BookmarkScreen()),

      // The chat screen, which takes receiver information as an extra parameter.
      GoRoute(
          path: chatScreen,
          builder: (context, state) => ChatScreen(
                receiverName: state.extra != null
                    ? (state.extra as ChatModel).receiverName
                    : 'Receiver Name',
                receiverImageUrl: state.extra != null
                    ? (state.extra as ChatModel).receiverImageUrl
                    : 'https://i.pravatar.cc/150?img=3',
              )),
      GoRoute(
        path: teacherHome, // new route for teacher homepage
        builder: (context, state) => TeacherApp(),
      ),
    ],
  );
}
