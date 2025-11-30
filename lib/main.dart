// Import necessary packages for routing, local storage, theme, Firebase, and Flutter material design.
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/theme.dart';
import 'package:edunity/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// The main entry point of the application.

late ValueNotifier<bool> darkModeNotifier;

void main() async {
  // Ensure that the Flutter binding is initialized before any Flutter-specific code is executed.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize shared preferences for local storage.
  await SharedPref.init();

  // Initialize dark mode notifier after shared preferences are ready
  darkModeNotifier = ValueNotifier(SharedPref.getDarkMode() ?? false);

  // Run the main application widget.
  runApp(const MainApp());
}

// The root widget of the aplication.
class MainApp extends StatelessWidget {
  // Constructor for the MainApp widget.
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: darkModeNotifier,
        builder: (context, box, child) {
          bool isDark = SharedPref.getDarkMode() ?? false;
          return MaterialApp.router(
            routerConfig: Routes.routes,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          );
        });
  }
}
