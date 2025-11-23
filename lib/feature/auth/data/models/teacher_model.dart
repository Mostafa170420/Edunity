class TeacherModel {
  final String? uid; // Firebase Auth UID
  final String? name;
  final String? email;
  final String? avatarUrl;

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
    this.uploadedCourses = const [],
    this.liveSessions = const [],
    this.receivedRequests = const [],
    this.rating,
    this.ratingCount,
    this.earnings,
    this.balance,
  });

  /// Firestore → Model
  factory TeacherModel.fromMap(Map<String, dynamic> map, String uid) {
    return TeacherModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
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
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'uploadedCourses': uploadedCourses,
      'liveSessions': liveSessions,
      'receivedRequests': receivedRequests,
      'rating': rating,
      'ratingCount': ratingCount,
      'earnings': earnings,
      'balance': balance,
    };
  }

  /// CopyWith (for partial updates)
  TeacherModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    List<String>? uploadedCourses,
    List<String>? liveSessions,
    List<String>? receivedRequests,
    double? rating,
    int? ratingCount,
    double? earnings,
    double? balance,
    DateTime? updatedAt,
  }) {
    return TeacherModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      uploadedCourses: uploadedCourses ?? this.uploadedCourses,
      liveSessions: liveSessions ?? this.liveSessions,
      receivedRequests: receivedRequests ?? this.receivedRequests,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      earnings: earnings ?? this.earnings,
      balance: balance ?? this.balance,
    );
  }

  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (rating != null) data['rating'] = rating;
    if (earnings != null) data['earnings'] = earnings;
    if (balance != null) data['balance'] = balance;
    return data;
  }
}
