class StudentModel {
  final String? uid; // Firebase Auth UID
  final String? name;
  final String? email;
  final String? avatarUrl;

  // Learning activity
  final List<String?> purchasedCourses; // courseIds
  final List<String?> joinedSessions; // liveSessionIds
  final List<String?> sentRequests; // studentRequestIds

  StudentModel({
    this.uid,
    this.name,
    this.email,
    this.avatarUrl,
    this.purchasedCourses = const [
      // courseIds

    ],
    this.joinedSessions = const [
      // liveSessionIds
    ],
    this.sentRequests = const [
      // studentRequestIds
    ],
  });

  /// Convert Firestore → Model
  factory StudentModel.fromMap(Map<String, dynamic> map, String uid) {
    return StudentModel(
      uid: uid,
      name: map['name'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      purchasedCourses: List<String>.from(map['purchasedCourses'] ?? []),
      joinedSessions: List<String>.from(map['joinedSessions'] ?? []),
      sentRequests: List<String>.from(map['sentRequests'] ?? []),
    );
  }

  /// Convert Model → Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'purchasedCourses': purchasedCourses,
      'joinedSessions': joinedSessions,
      'sentRequests': sentRequests,
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
      avatarUrl: avatarUrl ?? this.avatarUrl,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,
      joinedSessions: joinedSessions ?? this.joinedSessions,
      sentRequests: sentRequests ?? this.sentRequests,
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
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (purchasedCourses != null) data['purchasedCourses'] = purchasedCourses;
    if (joinedSessions != null) data['joinedSessions'] = joinedSessions;
    if (sentRequests != null) data['sentRequests'] = sentRequests;
    return data;
  }
}
