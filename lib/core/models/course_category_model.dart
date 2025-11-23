import 'package:edunity/core/constants/app_assets.dart';

/// A model that represents a category.
class CategoryModel {
  final String id;

  /// The path to the category's image.
  final String image;
  
  /// The name of the category.
  final String name;

  /// Creates a new [CategoryModel].
  CategoryModel(this.id, {
    required this.name,
    required this.image,
  });
}

/// A list of all the available categories.
List<CategoryModel> categories = [

];
