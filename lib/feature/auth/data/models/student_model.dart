class StudentModel {
  final String? uid; // Firebase Auth UID
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? dob;
  final String? bio;

  // Learning activity
  final List<String> purchasedCourses; // courseIds
  final List<String> completedCourses; // completed courseIds
  final Map<String, double>? courseProgress; // courseId -> progress %
  final List<String> joinedSessions; // liveSessionIds
  final List<String> sentRequests; // studentRequestIds

  // NEW: Bookmarked courses
  final List<String> bookmarkedCourses;

  // Preferences
  final bool darkMode;

  StudentModel({
    this.uid,
    this.name,
    this.email,
    this.avatarUrl,
    this.dob,
    this.bio,
    this.purchasedCourses = const [],
    this.completedCourses = const [],
    this.courseProgress,
    this.joinedSessions = const [],
    this.sentRequests = const [],
    this.bookmarkedCourses = const ['Fuck Firestore'],
    this.darkMode = false,
  });

  /// Convert Firestore → Model
  factory StudentModel.fromJson(Map<String, dynamic> map, String uid) {
    return StudentModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      dob: map['dob'],
      bio: map['bio'],
      purchasedCourses: List<String>.from(map['purchasedCourses'] ?? []),
      completedCourses: List<String>.from(map['completedCourses'] ?? []),
      courseProgress: map['courseProgress'] != null
          ? Map<String, double>.from(map['courseProgress'])
          : {},
      joinedSessions: List<String>.from(map['joinedSessions'] ?? []),
      sentRequests: List<String>.from(map['sentRequests'] ?? []),

      // NEW
      bookmarkedCourses: List<String>.from(map['bookmarkedCourses'] ?? []),

      darkMode: map['darkMode'] ?? false,
    );
  }

  /// Convert Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'dob': dob,
      'bio': bio,
      'purchasedCourses': purchasedCourses,
      'completedCourses': completedCourses,
      'courseProgress': courseProgress,
      'joinedSessions': joinedSessions,
      'sentRequests': sentRequests,

      // NEW
      'bookmarkedCourses': bookmarkedCourses,

      'darkMode': darkMode,
    };
  }

  /// CopyWith (for updates)
  StudentModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? dob,
    String? bio,
    List<String>? purchasedCourses,
    List<String>? completedCourses,
    Map<String, double>? courseProgress,
    List<String>? joinedSessions,
    List<String>? sentRequests,
    List<String>? bookmarkedCourses,
    bool? darkMode,
  }) {
    return StudentModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dob: dob ?? this.dob,
      bio: bio ?? this.bio,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
      completedCourses: completedCourses ?? this.completedCourses,
      courseProgress: courseProgress ?? this.courseProgress,
      joinedSessions: joinedSessions ?? this.joinedSessions,
      sentRequests: sentRequests ?? this.sentRequests,

      // NEW
      bookmarkedCourses: bookmarkedCourses ?? this.bookmarkedCourses,

      darkMode: darkMode ?? this.darkMode,
    );
  }

  /// Build partial update map for Firestore
  Map<String, dynamic> toUpdateData() {
    final data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (dob != null) data['dob'] = dob;
    if (bio != null) data['bio'] = bio;

    if (purchasedCourses.isNotEmpty) {
      data['purchasedCourses'] = purchasedCourses;
    }
    data['completedCourses'] = completedCourses;
    if (courseProgress != null) data['courseProgress'] = courseProgress;
    if (joinedSessions.isNotEmpty) {
      data['joinedSessions'] = joinedSessions;
    }
    if (sentRequests.isNotEmpty) {
      data['sentRequests'] = sentRequests;
    }

    // NEW
    if (bookmarkedCourses.isNotEmpty) {
      data['bookmarkedCourses'] = bookmarkedCourses;
    }

    data['darkMode'] = darkMode;

    return data;
  }
}
