class StudentModel {
  final String? uid; // Firebase Auth UID
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarUrl;

  // Learning activity
  final List<String?> purchasedCourses; // courseIds
  final List<String?> joinedSessions; // liveSessionIds
  final List<String?> sentRequests; // studentRequestIds

  // Engagement
  final double? rating; // avg rating across teachers
  final int? ratingCount;

  StudentModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.purchasedCourses = const [],
    this.joinedSessions = const [],
    this.sentRequests = const [],
    this.rating,
    this.ratingCount,
  });

  /// Convert Firestore → Model
  factory StudentModel.fromMap(Map<String, dynamic> map, String uid) {
    return StudentModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      purchasedCourses: List<String>.from(map['purchasedCourses'] ?? []),
      joinedSessions: List<String>.from(map['joinedSessions'] ?? []),
      sentRequests: List<String>.from(map['sentRequests'] ?? []),
      rating: (map['rating'] ?? 0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
    );
  }

  /// Convert Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'purchasedCourses': purchasedCourses,
      'joinedSessions': joinedSessions,
      'sentRequests': sentRequests,
      'rating': rating,
      'ratingCount': ratingCount,
    };
  }

  /// CopyWith (for updates)
  StudentModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    List<String>? purchasedCourses,
    List<String>? joinedSessions,
    List<String>? sentRequests,
    double? rating,
    int? ratingCount,
    DateTime? updatedAt,
  }) {
    return StudentModel(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
      joinedSessions: joinedSessions ?? this.joinedSessions,
      sentRequests: sentRequests ?? this.sentRequests,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }

  Map<String, dynamic> toUpdateData({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    List<String>? purchasedCourses,
    List<String>? joinedSessions,
    List<String>? sentRequests,
    double? rating,
    int? ratingCount,
  }) {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (purchasedCourses != null) data['purchasedCourses'] = purchasedCourses;
    if (joinedSessions != null) data['joinedSessions'] = joinedSessions;
    if (sentRequests != null) data['sentRequests'] = sentRequests;
    if (rating != null) data['rating'] = rating;
    if (ratingCount != null) data['ratingCount'] = ratingCount;
    return data;
  }
}
