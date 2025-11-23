/// A model representing a course.
// lib/core/model/course_model.dart

class CourseModel {
  final String id;
  final String title;
  final String description;
  final String mentorId;
  final String mentorName;
  final String categoryId;
  final String imageUrl;
  final Duration? totalDuration;

  final double price;
  final String videoUrl;
  // final bool completed;
  // final double progressPercent;
  final int lessonsCount;
  final int studentsEnrolled;
  final double rating;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mentorId,
    required this.mentorName,
    required this.categoryId,
    required this.imageUrl,
    required this.videoUrl,
    required this.price,
    // required this.completed,
    // required this.progressPercent,
    required this.lessonsCount,
    required this.studentsEnrolled,
    required this.rating,
    this.totalDuration,
  });

  // This method converts the object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'title': title,
      'description': description,
      'mentorId': mentorId,
      'mentorName': mentorName,
      'categoryId': categoryId,
      'imageUrl': imageUrl,
      'price': price,
      'videoUrl': videoUrl,
      // 'completed': completed,
      // 'progressPercent': progressPercent,
      'lessonsCount': lessonsCount,
      'studentsEnrolled': studentsEnrolled,
      'rating': rating,
      'totalDuration': totalDuration?.inMinutes,
    };
  }

  // This factory constructor creates an object from a Firestore document
  factory CourseModel.fromMap(String id, Map<String, dynamic> map) {
    return CourseModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      mentorId: map['mentorId'] ?? '',
      mentorName: map['mentorName'] ?? '',
      categoryId: map['categoryId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      lessonsCount: map['lessonsCount'] ?? 0,
      studentsEnrolled: map['studentsEnrolled'] ?? 0,
      rating: (map['rating'] ?? 0.0).toDouble(),
      // completed: map['completed'] ?? false,
      // progressPercent: map['progressPercent'] ?? 0.0,
      price: (map['price'] ?? 0.0).toDouble(),
      totalDuration: Duration(minutes: map['totalDuration'] ?? 0),
    );
  }
}

List<CourseModel> courses = [
  CourseModel(
    id: 'course1',
    title: 'Introduction to Flutter',
    description: 'Learn the basics of Flutter development.',
    mentorId: 'mentor1',
    mentorName: 'John Doe',
    categoryId: 'Development',
    imageUrl: 'https://example.com/flutter.jpg',
    videoUrl: 'https://example.com/flutter_video.mp4',
    price: 19.99,
    // completed: false,
    // progressPercent: 0.5,
    lessonsCount: 10,
    studentsEnrolled: 1500,
    rating: 4.5,
  ),
  CourseModel(
    id: 'course2',
    title: 'Web Development Fundamentals',
    description: 'Learn the fundamentals of web development.',
    mentorId: 'mentor2',
    mentorName: 'Jane Smith',
    categoryId: 'Development',
    imageUrl: 'https://example.com/web_development.jpg',
    videoUrl: 'https://example.com/web_development_video.mp4',
    price: 29.99,
    // completed: true,
    // progressPercent: 1.0,
    lessonsCount: 8,
    studentsEnrolled: 1200,
    rating: 4.2,
  ),
  CourseModel(
    id: 'course3',
    title: 'Data Science Basics',
    description: 'Learn the basics of data science.',
    mentorId: 'mentor3',
    mentorName: 'Bob Johnson',
    categoryId: 'Data Science',
    imageUrl: 'https://example.com/data_science.jpg',
    videoUrl: 'https://example.com/data_science_video.mp4',
    price: 39.99,
    // completed: false,
    // progressPercent: 0.3,
    lessonsCount: 12,
    studentsEnrolled: 1800,
    rating: 4.0,
  ),
  CourseModel(
    id: 'course4',
    title: 'Machine Learning Fundamentals',
    description: 'Learn the fundamentals of machine learning.',
    mentorId: 'mentor4',
    mentorName: 'Alice Brown',
    categoryId: 'Machine Learning',
    imageUrl: 'https://example.com/machine_learning.jpg',
    videoUrl: 'https://example.com/machine_learning_video.mp4',
    price: 49.99,
    // completed: true,
    // progressPercent: 0.9,
    lessonsCount: 15,
    studentsEnrolled: 2000,
    rating: 4.7,
  ),
];
