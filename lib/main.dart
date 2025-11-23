// Import necessary packages for routing, local storage, theme, Firebase, and Flutter material design.
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/theme.dart';
import 'package:edunity/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// The main entry point of the application.
void main() async {
  // Ensure that the Flutter binding is initialized before any Flutter-specific code is executed.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize shared preferences for local storage.
  SharedPref.init();
  
  // Run the main application widget.
  runApp(const MainApp());
}

// The root widget of the aplication.
class MainApp extends StatelessWidget {
  // Constructor for the MainApp widget.
  const MainApp({super.key});

  // Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    // MaterialApp.router is used for applications that use the new router API.
    return MaterialApp.router(
      // The router configuration for the application.
      routerConfig: Routes.routes,
      
      // Hide the debug banner in the top-right corner of the screen.
      debugShowCheckedModeBanner: false,
      
      // The light theme for the application.
      theme: AppTheme.lightTheme,
    );
  }
}
