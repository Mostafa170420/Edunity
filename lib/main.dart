import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/theme.dart';
import 'package:edunity/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPref.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
