import 'package:flutter/foundation.dart';

class MentorModel {
  final String name;
  final String image;

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

  MentorModel({
    required this.image,
    required this.name,
  });
}

// List<MentorModel> mentors =
