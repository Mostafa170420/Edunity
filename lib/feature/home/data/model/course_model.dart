class CourseModel {
  final String? id; // Firestore document ID
  final String? category;
  final String? duration; // e.g., "1:36:10"
  final String? instructor;
  final String? language;
  final String? level;
  final String? name;
  final int? numberOfVideos;
  final double? rating;
  final String? thumbnail;
  //final List<String>? videoLinks; // URLs to videos
  final String? dbLocation; // e.g., "nam5"

  CourseModel({
    this.id,
    this.category,
    this.duration,
    this.instructor,
    this.language,
    this.level,
    this.name,
    this.numberOfVideos,
    this.rating,
    this.thumbnail,
    //  this.videoLinks = const [],
    this.dbLocation,
  });

  /// Firestore → Model
  factory CourseModel.fromJson(Map<String, dynamic> map, {String? id}) {
    return CourseModel(
      id: id,
      category: map['category'] ?? '',
      duration: map['duration'] ?? '',
      instructor: map['instructor'] ?? '',
      language: map['language'] ?? '',
      level: map['level'] ?? '',
      name: map['name'] ?? '',
      numberOfVideos: map['numberOfVideos'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      thumbnail: map['thumbnail'] ?? '',
      //  videoLinks: List<String>.from(map['videoLinks'] ?? []),
      dbLocation: map['dbLocation'] ?? '',
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'duration': duration,
      'instructor': instructor,
      'language': language,
      'level': level,
      'name': name,
      'numberOfVideos': numberOfVideos,
      'rating': rating,
      'thumbnail': thumbnail,
      // 'videoLinks': videoLinks,
      'dbLocation': dbLocation,
    };
  }

  /// CopyWith for partial updates
  CourseModel copyWith({
    String? category,
    String? duration,
    String? instructor,
    String? language,
    String? level,
    String? name,
    int? numberOfVideos,
    double? rating,
    String? thumbnail,
    //  List<String>? videoLinks,
    String? dbLocation,
  }) {
    return CourseModel(
      id: id,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      instructor: instructor ?? this.instructor,
      language: language ?? this.language,
      level: level ?? this.level,
      name: name ?? this.name,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
      //   videoLinks: videoLinks ?? this.videoLinks,
      dbLocation: dbLocation ?? this.dbLocation,
    );
  }

  /// Partial update data for Firestore
  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) data['category'] = category;
    if (duration != null) data['duration'] = duration;
    if (instructor != null) data['instructor'] = instructor;
    if (language != null) data['language'] = language;
    if (level != null) data['level'] = level;
    if (name != null) data['name'] = name;
    if (numberOfVideos != null) data['numberOfVideos'] = numberOfVideos;
    if (rating != null) data['rating'] = rating;
    if (thumbnail != null) data['thumbnail'] = thumbnail;
    // if (videoLinks != null) data['videoLinks'] = videoLinks;
    if (dbLocation != null) data['dbLocation'] = dbLocation;
    return data;
  }
}

Map<String, String> courses = {
  " Blender 4.0 Beginner Donut Tutorial (Newest)": "2Bz9t17Yb3P317IT8Flg",
  "Financial Accounting Course": "5A0t5bMjH6y4McGdb2tY",
  "Programming & Web Development Crash Courses": "5ySUxDnmfYBtYamk48Wz",
  " Microsoft Office Tutorials": "78ZsJD0wB5TcDElZhCnd",
};
