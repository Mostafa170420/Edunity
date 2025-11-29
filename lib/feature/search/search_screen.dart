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
                        searchText = searchKey.trim();
                      });
                    },
                    suffixIcon: GradientButton(
                      label: '',
                      onPressed: () {
                        setState(() {
                          searchText = searchController.text.trim();
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

                    final data = snapshot.data!;
                    final courses = data.docs
                        .map((doc) => CourseModel.fromJson(
                            doc.data() as Map<String, dynamic>))
                        .toList();

                    log('📝 Processed ${courses.length} courses');

                    for (var course in courses) {
                      log('Found course: ${course.name}');
                    }

                    return GridView.builder(
                      itemCount: courses.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio:
                            0.7, // adjust to make cards taller/shorter
                      ),
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return GestureDetector(
                          onTap: () => pushTo(context, Routes.courseDetails,
                              extra: course),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Stack(
                                children: [
                                  Image.network(
                                    course.thumbnail ?? AppAssets.placeholder,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    top: 80, // adjust overlay height
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.primaryLightColor
                                                .withValues(alpha: 0),
                                            AppColors.primaryDarkColor
                                                .withValues(alpha: 0.6),
                                            AppColors.primaryLightColor
                                                .withValues(alpha: 0.8),
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.darkgreyColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              ' ${course.category} ',
                                              style: TextStyles.getSmall(
                                                  color: AppColors.whiteColor
                                                      .withAlpha(200),
                                                  fontSize: 12),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            course.name ?? '',
                                            style: TextStyles.getBody(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Gap(4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.star,
                                                      color:
                                                          AppColors.orangeColor,
                                                      size: 16),
                                                  Text(
                                                    '${course.rating}',
                                                    style: TextStyles.getBody(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .whiteColor),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '\$49.99',
                                                style: TextStyles.getBody(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.whiteColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
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
