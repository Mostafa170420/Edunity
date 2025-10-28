

import 'package:edunity/core/model/course_model.dart';
import 'package:flutter/material.dart';

class StudentUserModel {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final List<CoursesModel> enrolledCourses = [
    // Example enrolled courses
    CoursesModel(
      id: 'course1',
      title: 'Introduction to Flutter',
      description: 'Learn the basics of Flutter development.',
      category: 'Development',
      imageUrl: 'https://img-c.udemycdn.com/course/750x422/4544392_2838_3.jpg',
      completed: false,
      progressPercent: 0.5,
      lessonsCount: 123,
      studentsEnrolled: 1500,
      rating: 4.1,
      price: 19.99,
      totalDuration: const TimeOfDay(hour: 10, minute: 30), 
    ),
    CoursesModel(
      id: 'course2',
      title: 'Introduction to Python',
      description: 'Learn the basics of Python programming.',
      category: 'Programming',
      imageUrl: 'https://goedu.ac/wp-content/uploads/2023/09/Advanced-Python-Programming-Course-Image.webp',
      completed: false,
      progressPercent: 0.8,
      lessonsCount: 60,
      studentsEnrolled: 3500,
      rating: 4.1,
      price: 15.99,
      totalDuration: const TimeOfDay(hour: 5, minute: 30), 
      
    ),

    CoursesModel(
      id: 'course2',
      title: 'Advanced Dart Programming',
      description: 'Deep dive into Dart programming language.',
      category: 'Programming',
      imageUrl: 'https://i.ytimg.com/vi/CzRQ9mnmh44/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBu6_ClACrKjbe6kziZMXdt9EZr4Q',
      progressPercent: 0.3,
      completed: false,
      lessonsCount: 200,
      studentsEnrolled: 1900,
      rating: 3.9,
      price: 49.99,
      totalDuration: const TimeOfDay(hour: 15, minute: 30), 
    ),

    CoursesModel(
      id: 'course3',
      title: 'UI/UX Design Fundamentals',
      description: 'Learn the principles of UI/UX design.',
      category: 'Design',
      imageUrl: 'https://moontelict.com/wp-content/uploads/2024/11/course_1662637290-1.jpg',
      completed: true,
      progressPercent: 1.0,
      lessonsCount: 80,
      studentsEnrolled: 2200,
      rating: 4.5,
      price: 29.99,
      totalDuration: const TimeOfDay(hour: 8, minute: 0),
    ),
  ];


  StudentUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePictureUrl,
  });
  
}

var fakeStudent = StudentUserModel(
  id: 'student1',
  name: 'John Doe',
  email: 't8G7o@example.com',
  profilePictureUrl: 'https://example.com/john_doe.jpg',
);