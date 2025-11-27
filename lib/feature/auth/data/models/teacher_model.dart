class TeacherModel {
  final String? uid; // Firebase Auth UID
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final String? dob; // Date of birth
  final bool darkMode; // User preference for dark mode

  // Courses & Sessions
  final List<String?> uploadedCourses; // courseIds
  final List<String?> liveSessions; // liveSessionIds
  final List<String?> receivedRequests; // studentRequestIds

  // Ratings & Reviews
  final double? rating; // average rating from students
  final int? ratingCount;

  // Financial
  final double? earnings; // total earnings
  final double? balance; // available balance

  TeacherModel({
    this.uid,
    this.name,
    this.email,
    this.avatarUrl,
    this.bio,
    this.dob,
    this.darkMode = false,
    this.uploadedCourses = const [],
    this.liveSessions = const [],
    this.receivedRequests = const [],
    this.rating,
    this.ratingCount,
    this.earnings,
    this.balance,
  });

  /// Firestore → Model
  factory TeacherModel.fromJson(Map<String, dynamic> map, String uid) {
    return TeacherModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      bio: map['bio'] ?? '',
      dob: map['dob'] ?? '',
      darkMode: map['darkMode'] ?? false,
      uploadedCourses: List<String>.from(map['uploadedCourses'] ?? []),
      liveSessions: List<String>.from(map['liveSessions'] ?? []),
      receivedRequests: List<String>.from(map['receivedRequests'] ?? []),
      rating: (map['rating'] ?? 0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
      earnings: (map['earnings'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
    );
  }

  /// Model → Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'dob': dob,
      'darkMode': darkMode,
      'uploadedCourses': uploadedCourses,
      'liveSessions': liveSessions,
      'receivedRequests': receivedRequests,
      'rating': rating,
      'ratingCount': ratingCount,
      'earnings': earnings,
      'balance': balance,
    };
  }

  /// CopyWith for partial updates
  TeacherModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    String? dob,
    bool? darkMode,
    List<String>? uploadedCourses,
    List<String>? liveSessions,
    List<String>? receivedRequests,
    double? rating,
    int? ratingCount,
    double? earnings,
    double? balance,
  }) {
    return TeacherModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      dob: dob ?? this.dob,
      darkMode: darkMode ?? this.darkMode,
      uploadedCourses: uploadedCourses ?? this.uploadedCourses,
      liveSessions: liveSessions ?? this.liveSessions,
      receivedRequests: receivedRequests ?? this.receivedRequests,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      earnings: earnings ?? this.earnings,
      balance: balance ?? this.balance,
    );
  }

  /// Partial update data for Firestore
  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (bio != null) data['bio'] = bio;
    if (dob != null) data['dob'] = dob;
    data['darkMode'] = darkMode;
    if (rating != null) data['rating'] = rating;
    if (earnings != null) data['earnings'] = earnings;
    if (balance != null) data['balance'] = balance;
    return data;
  }
}
