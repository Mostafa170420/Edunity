import 'package:edunity/core/constants/app_assets.dart';

/// A model that represents a category.
class CategoryModel {
  /// The path to the category's image.
  final String image;

  /// The name of the category.
  final String name;

  /// Creates a new [CategoryModel].
  CategoryModel({
    required this.name,
    required this.image,
  });
}

/// A list of all the available categories.
List<CategoryModel> categories = [
  CategoryModel(image: AppAssets.design_3D, name: '3D Design'),
  CategoryModel(image: AppAssets.graphic_Design, name: 'Graphic Design'),
  CategoryModel(image: AppAssets.accounting, name: 'Finance & Accounting'),
  CategoryModel(image: AppAssets.hr_Management, name: 'HR Management'),
  CategoryModel(image: AppAssets.marketing, name: 'SEO & Marketing'),
  CategoryModel(
      image: AppAssets.office_Productivity, name: 'Office Productivity'),
  CategoryModel(
      image: AppAssets.personal_development, name: 'Personal Development'),
  CategoryModel(image: AppAssets.web_development, name: 'Web Development'),
];
