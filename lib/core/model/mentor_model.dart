import 'package:edunity/core/constants/app_assets.dart';
import 'package:flutter/foundation.dart';

/// A model representing a mentor.
class MentorModel {
  /// The name of the mentor.
  final String name;

  /// The URL of the mentor's image.
  final String image;

  /// A list of the top mentors.
  static List<MentorModel> topMentors = [
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${655655}', name: 'Samantha '),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'John'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Emma'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Michael'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Olivia'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'James'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Ava'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'William'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Isabella'),
    MentorModel(
        image: 'https://i.pravatar.cc/231?u=${UniqueKey().hashCode}',
        name: 'Benjamin'),
  ];

  /// Creates a new [MentorModel] instance.
  MentorModel({
    required this.image,
    required this.name,
  });
}

// List<MentorModel> mentors =
