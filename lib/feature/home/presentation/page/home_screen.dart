import 'dart:developer';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(horizontal: 15);
    final searchController = TextEditingController();
    var user = SharedPref.getUserId();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          FutureBuilder(
            future: userType == UserTypeEnum.student
                ? FirebaseProvider.getStudentByID(user)
                : FirebaseProvider.getTeacherByID(user),
            builder: (context, snapshot) {
              log('snapshot state: ${snapshot.connectionState}');
              var data = snapshot.data!.data() as Map<String, dynamic>;
              log('snapshot data: ${data['name']}');

              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const SliverToBoxAdapter(
              //     child: SizedBox(
              //       height: 80,
              //       child: Center(child: CircularProgressIndicator()),
              //     ),
              //   );
              // }

              if (!snapshot.hasData || snapshot.data == null) {
                return CustomSliverAppBar(
                  userName: "User",
                  onNotificationTap: () {
                    pushTo(context, Routes.notifications);
                  },
                );
              }

              return CustomSliverAppBar(
                userName: '${data['name']}',
                onNotificationTap: () {
                  pushTo(context, Routes.notifications);
                },
              );
            },
          ),

          // Search Field
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Hero(
                tag: 'searchFieldHero',
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: padding,
                    child: CustomTextField(
                      controller: searchController,
                      hintText: 'Search for...',
                      readOnly: true,
                      onTap: () => pushTo(context, Routes.search),
                      suffixIcon: const Icon(IconlyBroken.search),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Slider
          SliverToBoxAdapter(child: homeslider()),

          // Categories
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CategoriesSection(padding: padding),
            ),
          ),

          // Popular Courses
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCoursesSection(padding: padding),
            ),
          ),

          // Top Mentors
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
