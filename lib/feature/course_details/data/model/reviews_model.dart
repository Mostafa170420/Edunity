class ReviewsModel {
  final String name;
  final DateTime date;
  final int rating;
  final String description;

  ReviewsModel(
      {required this.name,
      required this.date,
      required this.rating,
      required this.description});
}

final List<ReviewsModel> reviews = [
  ReviewsModel(
      name: "John Smith",
      date: DateTime.timestamp(),
      rating: 5,
      description:
          "Excellent Course! Dr.Sarah explains complex concepts in a very understandable way"),
  ReviewsModel(
      name: "Emily Chen",
      date: DateTime.now(),
      rating: 5,
      description:
          "The course helped me ace my calculus exam. Highly recommended!"),
];
