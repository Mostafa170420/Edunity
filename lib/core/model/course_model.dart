import 'package:flutter/material.dart';

/// A model representing a course.
class CoursesModel {
  /// The unique identifier for the course.
  final String? id;

  /// The title of the course.
  final String title;

  /// The URL of the course's image.
  final String? imageUrl;

  /// The category of the course.
  final String? category;

  /// The description of the course.
  final String? description;

  /// The price of the course.
  final double? price;

  /// The rating of the course.
  final double? rating;

  /// The number of students enrolled in the course.
  final int? studentsEnrolled;

  /// Whether the course has been completed.
  final bool? completed;

  /// The percentage of the course that has been completed.
  final double? progressPercent;

  /// The number of lessons in the course.
  final int? lessonsCount;

  /// The total duration of the course.
  final TimeOfDay? totalDuration;

  /// A list of all the available courses.
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

  /// Creates a new [CoursesModel] instance.
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
