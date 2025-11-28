class CourseModel {
  final String? id; // Firestore document ID
  final String? category;
  final String? duration;
  final String? description;
  final String? instructor;
  final String? language;
  final String? level;
  final String? name;
  final int? numberOfVideos;
  final double? rating;
  final String? thumbnail;
  //final List<String>? videoLinks; // URLs to videos

  CourseModel({
    this.id,
    this.category,
    this.duration,
    this.description,
    this.instructor,
    this.language,
    this.level,
    this.name,
    this.numberOfVideos,
    this.rating,
    this.thumbnail,
    //  this.videoLinks = const [],
  });

  /// Firestore → Model
  factory CourseModel.fromJson(Map<String, dynamic> map, {String? id}) {
    return CourseModel(
      id: id,
      category: map['category'] ?? '',
      duration: map['duration'] ?? '',
      description: map['description'] ?? '',
      instructor: map['instructor'] ?? '',
      language: map['language'] ?? '',
      level: map['level'] ?? '',
      name: map['name'] ?? '',
      numberOfVideos: map['numberOfVideos'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      thumbnail: map['thumbnail'] ?? '',
      //  videoLinks: List<String>.from(map['videoLinks'] ?? []),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'duration': duration,
      'description': description,
      'instructor': instructor,
      'language': language,
      'level': level,
      'name': name,
      'numberOfVideos': numberOfVideos,
      'rating': rating,
      'thumbnail': thumbnail,
      // 'videoLinks': videoLinks,
    };
  }

  /// CopyWith for partial updates
  CourseModel copyWith({
    String? category,
    String? duration,
    String? description,
    String? instructor,
    String? language,
    String? level,
    String? name,
    int? numberOfVideos,
    double? rating,
    String? thumbnail,
    //  List<String>? videoLinks,
  }) {
    return CourseModel(
      id: id,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      language: language ?? this.language,
      level: level ?? this.level,
      name: name ?? this.name,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
      //   videoLinks: videoLinks ?? this.videoLinks,
    );
  }

  /// Partial update data for Firestore
  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) data['category'] = category;
    if (duration != null) data['duration'] = duration;
    if (description != null) data['description'] = description;
    if (instructor != null) data['instructor'] = instructor;
    if (language != null) data['language'] = language;
    if (level != null) data['level'] = level;
    if (name != null) data['name'] = name;
    if (numberOfVideos != null) data['numberOfVideos'] = numberOfVideos;
    if (rating != null) data['rating'] = rating;
    if (thumbnail != null) data['thumbnail'] = thumbnail;
    // if (videoLinks != null) data['videoLinks'] = videoLinks;

    return data;
  }
}

Map<String, String> courses = {
  "Blender 4.0 Beginner Donut Tutorial (Newest)": "2Bz9t17Yb3P317IT8Flg",
  "Financial Accounting Course": "5A0t5bMjH6y4McGdb2tY",
  "Programming & Web Development Crash Courses": "5ySUxDnmfYBtYamk48Wz",
  "Microsoft Office Tutorials": "78ZsJD0wB5TcDElZhCnd",
  "Animated Character Creation in Blender 3D": "7KFbKOVRwfyyotPqb1hU",
  "Human Resource Management (Complete Course)": "8DCA5VSZ0FOvVWnxlYmR",
  "Digital Marketing": "Po1v7lV9KZwFcebx1Lud",
  "Microsoft Excel Training Tutorials for Beginners": "UASqqXGLJGJjOHnJsBhP",
  "Web Development Tutorials For Beginners": "WPLNg0Fcnb5LbMXdIuTZ",
  "Self-Development, Productivity & Mastering Your Daily Life":
      "gCfU2dMW3624UeObhPIv",
  "Productivity & Self Development": "jURt6Ugdi9747wvyfqAS",
  "Graphic Design Fundamentals": "ktbSMAEBvF12WUhFC6oE",
  "Graphic Design Fundamentals Course": "my5mLrhzStit0fInFPkO",
  "Human Resource Management Training Programs": "ohkXo9us5HhiB4UEM2Fz",
  "Accounting Basics for Beginners": "xk8QpsyS1uIGSuDTFP1Q",
  "SEO Tutorials (Beginner to Advanced)": "zE4GvaDqPjTdh55QKNM6",
};
