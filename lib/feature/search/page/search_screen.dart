import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_list.dart';
import 'package:edunity/feature/search/widgets/courses_grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyles.getTitle(fontWeight: FontWeight.bold, fontSize: 21),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              IconlyLight.filter,
              color: AppColors.darkgreyColor,
            ),
            onPressed: () {
              pushTo(context, Routes.filter);
            },
          )
        ],
        actionsPadding: const EdgeInsets.only(right: 15),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            children: [
              Hero(
                tag: 'searchFieldHero',
                child: Material(
                  color: Colors.transparent,
                  child: CustomTextField(
                    controller: searchController,
                    hintText: 'Search For..',
                    onChanged: (searchKey) {
                      setState(() {
                        searchText = searchKey.trim().toLowerCase();
                      });
                    },
                    suffixIcon: GradientButton(
                      label: '',
                      onPressed: () {
                        setState(() {
                          searchText =
                              searchController.text.trim().toLowerCase();
                        });
                      },
                      width: 40,
                      borderRadius: 12,
                      icon:
                          const Icon(IconlyBroken.search, color: Colors.white),
                      iconAlignment: IconAlignment.end,
                    ),
                  ),
                ),
              ),
              const Gap(30),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseProvider.getCoursesByName(searchText),
                  key: ValueKey(searchText),
                  builder: (context, snapshot) {
                    log('=== FUTURE BUILDER CALLED ===');
                    log('Search text: "$searchText"');
                    log('Connection state: ${snapshot.connectionState}');
                    log('Has data: ${snapshot.hasData}');
                    log('Has error: ${snapshot.hasError}');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      log('⏳ Waiting for data...');
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      log('❌ Error: ${snapshot.error}');
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // Check what's in snapshot.data
                    if (snapshot.hasData) {
                      log('📊 Data received - docs length: ${snapshot.data!.docs.length}');
                      if (snapshot.data!.docs.isNotEmpty) {
                        log('✅ Found ${snapshot.data!.docs.length} documents');
                      } else {
                        log('📭 No documents found in query');
                      }
                    } else {
                      log('📭 No data at all');
                    }

                    // PROPER NULL CHECK
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      log('🚨 Returning empty widget');
                      return emptyWidget();
                    }

                    log('🎯 Reached data processing stage');

                    final courses = snapshot.data!.docs
                        .map((doc) => CourseModel.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    log('📝 Processed ${courses.length} courses');

                    for (var course in courses) {
                      log('Found course: ${course.name}');
                    }

                    return CoursesGridBuilder(courses: courses);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.search,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "No results found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
