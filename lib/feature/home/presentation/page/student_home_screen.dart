// Import necessary packages and widgets for the home screen.
import 'dart:developer';

import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/feature/auth/data/models/user_type_enum.dart';
import 'package:edunity/feature/home/presentation/bloc/home_bloc.dart';
import 'package:edunity/feature/home/presentation/bloc/home_event.dart';
import 'package:edunity/feature/home/presentation/bloc/home_state.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_sliver_app_bar.dart';
import 'package:edunity/feature/home/presentation/widgets/homeslider.dart';
import 'package:edunity/feature/home/presentation/widgets/popular_courses_section.dart';
import 'package:edunity/feature/home/presentation/widgets/top_teachers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key, required this.userType});
  final UserTypeEnum userType;

  @override
  State<StudentHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    super.initState();

    var bloc = context.read<HomeBloc>();
    bloc.add(DataLoadEvent(userType: UserTypeEnum.student));
  }

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(horizontal: 15);
    final searchController = TextEditingController();

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // Show loading dialog for any loading state
        if (state is HomeLoadingState) {
          log('Loading...');
          showLoadingDialog(context);
        }
        // Handle generic errors
        else if (state is HomeErrorState) {
          pop(context);
          showMyDialoge(
              context, state.message ?? 'An unexpected error occurred.');
        }
        // Handle success messages for general operations (e.g., upload)
        else if (state is HomeSuccessState) {
          pop(context);
          if (state.message != null) {
            showMyDialoge(
              context,
              state.message!,
              type: DialogeType.success,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CustomSliverAppBar(
                userName: (state is HomeSuccessState && state.userData != null)
                    ? (state.userData!['name'] as String?) ?? 'User'
                    : 'User',
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
                padding: const EdgeInsets.only(top: 25),
                child: (state is HomeSuccessState)
                    ? PopularCoursesSection(
                        padding: padding, courses: state.courses ?? [])
                    : SizedBox(),
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 100),
                  child: TopTeachersSection(padding: padding),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
