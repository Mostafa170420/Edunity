// Import necessary packages and widgets for the home screen.
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/widgets/categories_section.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:edunity/feature/home/presentation/widgets/homeslider.dart';
import 'package:edunity/feature/home/presentation/widgets/popular_courses_section.dart';
import 'package:edunity/feature/home/presentation/widgets/top_mentors_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

/// The `HomeScreen` is a stateless widget that represents the main screen of the application.
/// It displays a variety of content, including a search bar, a slider, course categories,
/// popular courses, and top mentors.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define horizontal padding for consistency across different sections.
    final padding = const EdgeInsets.symmetric(horizontal: 15);
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // The `CustomScrollView` allows for a flexible and scrollable layout with different types of content.
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // The custom app bar for the home screen, which includes a welcome message and a notification button.
          CustomSliverAppBar(
            userName: 'John Doe', // This should be replaced with the actual user's name.
            onNotificationTap: () {
              pushTo(context, Routes.notifications);
            },
          ),

          // A sliver that contains the search field.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Hero(
                tag: 'searchFieldHero', // A hero tag for the search field animation.
                child: Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: padding,
                    child: CustomTextField(
                      controller: searchController,
                      hintText: 'Search for...',
                      readOnly: true, // The search field is read-only and navigates to the search screen on tap.
                      onTap: () => pushTo(context, Routes.search),
                      suffixIcon: const Icon(IconlyBroken.search),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // A sliver that contains the image slider.
          SliverToBoxAdapter(child: homeslider()),

          // A sliver that contains the course categories section.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: CategoriesSection(padding: padding),
            ),
          ),

          // A sliver that contains the popular courses section.
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCoursesSection(padding: padding),
            ),
          ),

          // A sliver that contains the top mentors section.
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
