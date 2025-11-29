import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/feature/search/widgets/courses_grid_builder.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName,
            style:
                TextStyles.getTitle(fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future:
                    FirebaseProvider.getCoursesByCategory(widget.categoryName),
                // initialData: InitialData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
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
                  final courses = snapshot.data!.docs
                      .map((doc) => CourseModel.fromJson(
                          doc.data() as Map<String, dynamic>))
                      .toList();
                  return CoursesGridBuilder(courses: courses);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
