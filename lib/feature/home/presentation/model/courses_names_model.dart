class CoursesModel {
  final String title;
  final String? image;
  final String? courseCategorie;
  final String? description;
  final double? price;
  final double? rating;
  final int? numberOfStudents;

  CoursesModel({
    required this.title,
    this.courseCategorie = 'Programming',
    this.image =
        'https://www.emexotechnologies.com/wp-content/uploads/2024/05/Flutter-course-in-lucknow.png',
    this.description =
        'Learn the fundamentals of programming with this comprehensive course designed for beginners.',
    this.price = 49.99,
    this.rating = 4.5,
    this.numberOfStudents = 1200,
  });
}

List<CoursesModel> courses = [
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
