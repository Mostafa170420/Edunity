// Import necessary packages and screens for routing.
import 'package:edunity/core/model/chat_model.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:edunity/feature/auth/presentation/page/login/login_screen.dart';
import 'package:edunity/feature/auth/presentation/page/signup/register_screen.dart';
import 'package:edunity/feature/categories/All_category_screen.dart';
import 'package:edunity/feature/categories/category_screen.dart';
import 'package:edunity/feature/chat/page/chat_screen.dart';
import 'package:edunity/feature/course_details/pages/main_tab_screen.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/home/presentation/bloc/home_bloc.dart';
import 'package:edunity/feature/home/presentation/page/course_upload_screen.dart';
import 'package:edunity/feature/mentors/page/teacher_details_screen.dart';
import 'package:edunity/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:edunity/feature/profile/presentation/page/bookmarks_screen.dart';
import 'package:edunity/feature/search/page/filter_screen.dart';
import 'package:edunity/feature/search/page/search_screen.dart';
import 'package:edunity/feature/mentors/page/top_teacher_screen.dart';
import 'package:edunity/feature/main/main_screen.dart';
import 'package:edunity/feature/my%20courses/presentation/pages/my_courses_page.dart';
import 'package:edunity/feature/notification/presentation/pages/notifications.dart';
import 'package:edunity/feature/onboarding/page/welcome_screen.dart';
import 'package:edunity/feature/profile/presentation/page/edit_profile.dart';
import 'package:edunity/feature/profile/presentation/page/profile_screen.dart';
import 'package:edunity/feature/splash/splash_screen.dart';
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
  static const String allCategories = '/allCategories';
  static const String categoryScreen = '/categoryScreen';
  static const String search = '/search';
  static const String notifications = '/notifications';
  static const String mainprofile = '/profile';
  static const String myCourses = '/myCourses';
  static const String courseDetails = '/courseDetails';
  static const String teacherDetails = '/teacherDetails';
  static const String addCourses = '/addCourses';
  static const String editProfile = '/editProfile';
  static const String bookmark = '/bookmark';
  static const String topMentors = '/topMentors';
  static const String filter = '/filter';
  static const String chatScreen = '/chat';

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

      GoRoute(
        path: main,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => HomeBloc()),
            BlocProvider(create: (context) => ProfileBloc()),
          ],
          child: MainScreen(
            userType: state.extra as UserTypeEnum,
          ),
        ),
      ),
      GoRoute(
          path: allCategories,
          builder: (context, state) => AllCategoriesScreen()),

      GoRoute(
          path: categoryScreen,
          builder: (context, state) => CategoryScreen(
                categoryName: state.extra as String,
              )),

      // The search screen.
      GoRoute(path: search, builder: (context, state) => SearchScreen()),

      GoRoute(
          path: addCourses,
          builder: (context, state) => BlocProvider(
                create: (context) => HomeBloc(),
                child: TeacherAddCourseScreen(),
              )),

      // The notifications screen.
      GoRoute(
          path: notifications,
          builder: (context, state) => NotificationScreen()),

      // The user's profile screen.
      GoRoute(
        path: mainprofile,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileBloc(),
          child: ProfileScreen(),
        ),
      ),
      GoRoute(
          path: courseDetails,
          builder: (context, state) => MainTabScreen(
                course: state.extra as CourseModel,
              )),

      // The screen for the user's enrolled courses.
      GoRoute(
          path: topMentors,
          builder: (context, state) => TopteachersScreen(
                teachers: state.extra as List<TeacherModel>,
              )),

      // The filter screen for searching.
      GoRoute(path: filter, builder: (context, state) => FilterScreen()),

      // The screen for the user's enrolled courses.
      GoRoute(path: myCourses, builder: (context, state) => MyCourses()),

      GoRoute(
          path: teacherDetails,
          builder: (context, state) =>
              TeacherDetailsScreen(teacher: state.extra as TeacherModel)),

      // The screen for editing the user's profile.
      GoRoute(
          path: editProfile,
          builder: (context, state) => BlocProvider(
                create: (context) => ProfileBloc(),
                child: EditProfile(),
              )),

      // The screen for the user's bookmarked courses.
      GoRoute(path: bookmark, builder: (context, state) => BookmarksScreen()),

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
    ],
  );
}
