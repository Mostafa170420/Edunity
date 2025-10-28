import 'package:flutter/material.dart';

class CoursesModel {
  final String? id;

  final String title;
  final String? imageUrl;
  final String? category;
  final String? description;
  final double? price;
  final double? rating;
  final int? studentsEnrolled;
  final bool? completed;
  final double? progressPercent;
  // final int? studentsEnrolled;
  final int? lessonsCount;
  final TimeOfDay? totalDuration;

  static List<CoursesModel> courses = [
    CoursesModel(title: 'All'),
    CoursesModel(title: 'Introduction to Programming'),
    CoursesModel(title: 'Advanced Mathematics'),
    CoursesModel(title: 'Graphic Design Advanced'),
    CoursesModel(title: 'UI/UX Design'),
    CoursesModel(title: 'Web Development'),
    CoursesModel(title: 'Data Science'),
    CoursesModel(title: 'Digital Marketing'),
    CoursesModel(title: 'Cybersecurity'),
    CoursesModel(title: 'Project Management'),
    CoursesModel(title: 'Cloud Computing'),
    CoursesModel(title: 'Artificial Intelligence'),
  ];

  CoursesModel({
    this.id,
    this.completed,
    this.progressPercent,
    required this.title,
    this.category = 'Programming',
    this.imageUrl =
        'https://www.emexotechnologies.com/wp-content/uploads/2024/05/Flutter-course-in-lucknow.png',
    this.description =
        'Learn the fundamentals of programming with this comprehensive course designed for beginners.',
    this.price = 49.99,
    this.rating = 4.5,
    this.studentsEnrolled = 1200,
    this.lessonsCount,
    this.totalDuration,
  });
}
