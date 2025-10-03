import 'package:edunity/core/constants/app_assets.dart';

class MentorModel {
  final String name;
  final String image;

  MentorModel({
    required this.image,
    required this.name,
  });
}

List<MentorModel> mentors = [
  MentorModel(image: AppAssets.courseBackground, name: 'Samantha '),
  MentorModel(image: AppAssets.courseBackground, name: 'John'),
  MentorModel(image: AppAssets.courseBackground, name: 'Emma'),
  MentorModel(image: AppAssets.courseBackground, name: 'Michael'),
  MentorModel(image: AppAssets.courseBackground, name: 'Olivia'),
  MentorModel(image: AppAssets.courseBackground, name: 'James'),
  MentorModel(image: AppAssets.courseBackground, name: 'Ava'),
  MentorModel(image: AppAssets.courseBackground, name: 'William'),
  MentorModel(image: AppAssets.courseBackground, name: 'Isabella'),
  MentorModel(image: AppAssets.courseBackground, name: 'Benjamin'),
];
