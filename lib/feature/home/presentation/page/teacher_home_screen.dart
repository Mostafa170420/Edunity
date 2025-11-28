// Import necessary packages and widgets for the home screen.
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/home/presentation/widgets/categories_section.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:edunity/feature/home/presentation/widgets/homeslider.dart';
import 'package:edunity/feature/home/presentation/widgets/popular_courses_section.dart';
import 'package:edunity/feature/home/presentation/widgets/top_mentors_section.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<TeacherHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TeacherHomeScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = SharedPref.getUserId();
    final snapshot = widget.userType == UserTypeEnum.student
        ? await FirebaseProvider.getStudentByID(userId)
        : await FirebaseProvider.getTeacherByID(userId);

    setState(() {
      userData = snapshot.data() as Map<String, dynamic>?;
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(horizontal: 15);
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(
            userName: userData?['name'] ?? 'User',
            userType: widget.userType,
            onNotificationTap: () => pushTo(context, Routes.notifications),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Hero(
                tag:
                    'searchFieldHero', // A hero tag for the search field animation.
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: padding,
                    child: CustomTextField(
                      controller: searchController,
                      hintText: 'Search for...',
                      readOnly:
                          true, // The search field is read-only and navigates to the search screen on tap.
                      onTap: () => pushTo(context, Routes.search),
                      suffixIcon: const Icon(IconlyBroken.search),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: homeslider()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CategoriesSection(padding: padding),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCoursesSection(padding: padding),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 100),
              child: TopMentorsSection(padding: padding),
            ),
          ),
        ],
      ),
    );
  }
}
