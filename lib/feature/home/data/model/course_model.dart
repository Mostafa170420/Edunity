class CourseModel {
  final String? id; // Firestore document ID
  final String? category;
  final String? duration;
  final String? description;
  final String? instructor; // existing instructor name
  final String? instructorId; // 🔥 NEW FIELD (teacher UID)
  final String? language;
  final String? level;
  final String? name;

  // 🔥 NEW FIELD
  final String? nameLowercase;

  final int? numberOfVideos;
  final double? rating;
  final String? thumbnail;
  final List<String>? whatYouLearn;

  // NEW VIDEO FIELDS
  final List<String>? videoNames;
  final List<String>? videoLinks;
  final List<String>? videoDurations;

  bool completed = false;
  double progressPercent = 0.0;

  CourseModel({
    this.id,
    this.category,
    this.duration,
    this.description,
    this.instructor,
    this.instructorId, // 🔥 NEW
    this.language,
    this.level,
    this.name,
    this.nameLowercase,
    this.numberOfVideos,
    this.rating,
    this.thumbnail,
    this.whatYouLearn,
    this.videoNames,
    this.videoLinks,
    this.videoDurations,
    this.completed = false,
    this.progressPercent = 0.0,
  });

  /// Firestore → Model
  factory CourseModel.fromJson(Map<String, dynamic> map, {String? id}) {
    return CourseModel(
      id: id,
      category: map['category'] ?? '',
      duration: map['duration'] ?? '',
      description: map['description'] ?? '',
      instructor: map['instructor'] ?? '',
      instructorId: map['instructorId'] ?? '', // 🔥 NEW
      language: map['language'] ?? '',
      level: map['level'] ?? '',
      name: map['name'] ?? '',

      nameLowercase: map['nameLowercase'] ?? '',

      numberOfVideos: map['numberOfVideos'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      thumbnail: map['thumbnail'] ?? '',
      whatYouLearn: map['whatYouLearn'] != null
          ? List<String>.from(map['whatYouLearn'])
          : [],
      videoNames:
          map['videoNames'] != null ? List<String>.from(map['videoNames']) : [],
      videoLinks:
          map['videoLinks'] != null ? List<String>.from(map['videoLinks']) : [],
      videoDurations: map['videoDurations'] != null
          ? List<String>.from(map['videoDurations'])
          : [],
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'duration': duration,
      'description': description,
      'instructor': instructor,
      'instructorId': instructorId, // 🔥 NEW
      'language': language,
      'level': level,
      'name': name,
      'nameLowercase': nameLowercase,
      'numberOfVideos': numberOfVideos,
      'rating': rating,
      'thumbnail': thumbnail,
      'whatYouLearn': whatYouLearn,
      'videoNames': videoNames,
      'videoLinks': videoLinks,
      'videoDurations': videoDurations,
    };
  }

  /// CopyWith for partial updates
  CourseModel copyWith({
    String? category,
    String? duration,
    String? description,
    String? instructor,
    String? instructorId, // 🔥 NEW
    String? language,
    String? level,
    String? name,
    String? nameLowercase,
    int? numberOfVideos,
    double? rating,
    String? thumbnail,
    List<String>? whatYouLearn,
    List<String>? videoNames,
    List<String>? videoLinks,
    List<String>? videoDurations,
    bool? completed,
    double? progressPercent,
  }) {
    return CourseModel(
      id: id,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      instructor: instructor ?? this.instructor,
      instructorId: instructorId ?? this.instructorId, // 🔥 NEW
      language: language ?? this.language,
      level: level ?? this.level,
      name: name ?? this.name,
      nameLowercase: nameLowercase ?? this.nameLowercase,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
      whatYouLearn: whatYouLearn ?? this.whatYouLearn,
      videoNames: videoNames ?? this.videoNames,
      videoLinks: videoLinks ?? this.videoLinks,
      videoDurations: videoDurations ?? this.videoDurations,
      completed: completed ?? this.completed,
      progressPercent: progressPercent ?? this.progressPercent,
    );
  }

  /// Partial update for Firestore
  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (category != null) data['category'] = category;
    if (duration != null) data['duration'] = duration;
    if (description != null) data['description'] = description;
    if (instructor != null) data['instructor'] = instructor;
    if (instructorId != null) data['instructorId'] = instructorId; // 🔥 NEW
    if (language != null) data['language'] = language;
    if (level != null) data['level'] = level;
    if (name != null) data['name'] = name;
    if (nameLowercase != null) data['nameLowercase'] = nameLowercase;
    if (numberOfVideos != null) data['numberOfVideos'] = numberOfVideos;
    if (rating != null) data['rating'] = rating;
    if (thumbnail != null) data['thumbnail'] = thumbnail;
    if (whatYouLearn != null) data['whatYouLearn'] = whatYouLearn;
    if (videoNames != null) data['videoNames'] = videoNames;
    if (videoLinks != null) data['videoLinks'] = videoLinks;
    if (videoDurations != null) data['videoDurations'] = videoDurations;

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
