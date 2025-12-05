class TeacherModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? bio;
  final String? dob;
  final bool darkMode;
  final String? category;

  // Courses & Sessions
  final List<String> uploadedCourses;
  final List<String> liveSessions;
  final List<String> receivedRequests;

  // Bookmarked courses
  final List<String> bookmarkedCourses;

  // NEW: Completed & Purchased Courses
  final List<String> completedCourses;
  final List<String> purchasedCourses;

  // Ratings & Reviews
  final double? rating;
  final int? ratingCount;

  // Financial
  final double? earnings;
  final double? balance;

  TeacherModel({
    this.uid,
    this.name,
    this.email,
    this.avatarUrl,
    this.bio,
    this.dob,
    this.darkMode = false,
    this.category,
    this.uploadedCourses = const [],
    this.liveSessions = const [],
    this.receivedRequests = const [],
    this.bookmarkedCourses = const ['Fuck Firestore'],

    // NEW
    this.completedCourses = const [],
    this.purchasedCourses = const [],
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
      category: map['category'] ?? '',

      uploadedCourses: List<String>.from(map['uploadedCourses'] ?? []),
      liveSessions: List<String>.from(map['liveSessions'] ?? []),
      receivedRequests: List<String>.from(map['receivedRequests'] ?? []),

      bookmarkedCourses: List<String>.from(map['bookmarkedCourses'] ?? []),

      // NEW
      completedCourses: List<String>.from(map['completedCourses'] ?? []),
      purchasedCourses: List<String>.from(map['purchasedCourses'] ?? []),

      rating: double.tryParse(map['rating']?.toString() ?? '') ?? 0,
      ratingCount: int.tryParse(map['ratingCount']?.toString() ?? '') ?? 0,
      earnings: double.tryParse(map['earnings']?.toString() ?? '') ?? 0,
      balance: double.tryParse(map['balance']?.toString() ?? '') ?? 0,
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
      'category': category,

      'uploadedCourses': uploadedCourses,
      'liveSessions': liveSessions,
      'receivedRequests': receivedRequests,
      'bookmarkedCourses': bookmarkedCourses,

      // NEW
      'completedCourses': completedCourses,
      'purchasedCourses': purchasedCourses,

      'rating': rating,
      'ratingCount': ratingCount,
      'earnings': earnings,
      'balance': balance,
    };
  }

  /// CopyWith
  TeacherModel copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    String? dob,
    bool? darkMode,
    String? category,
    List<String>? uploadedCourses,
    List<String>? liveSessions,
    List<String>? receivedRequests,
    List<String>? bookmarkedCourses,
    List<String>? completedCourses,
    List<String>? purchasedCourses,
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
      category: category ?? this.category,

      uploadedCourses: uploadedCourses ?? this.uploadedCourses,
      liveSessions: liveSessions ?? this.liveSessions,
      receivedRequests: receivedRequests ?? this.receivedRequests,

      bookmarkedCourses: bookmarkedCourses ?? this.bookmarkedCourses,

      // NEW
      completedCourses: completedCourses ?? this.completedCourses,
      purchasedCourses: purchasedCourses ?? this.purchasedCourses,

      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      earnings: earnings ?? this.earnings,
      balance: balance ?? this.balance,
    );
  }

  /// Partial update for Firestore
  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
    if (bio != null) data['bio'] = bio;
    if (dob != null) data['dob'] = dob;

    data['darkMode'] = darkMode;

    if (category != null) data['category'] = category;
    if (rating != null) data['rating'] = rating;
    if (earnings != null) data['earnings'] = earnings;
    if (balance != null) data['balance'] = balance;

    if (bookmarkedCourses.isNotEmpty) {
      data['bookmarkedCourses'] = bookmarkedCourses;
    }

    // NEW
    if (completedCourses.isNotEmpty) {
      data['completedCourses'] = completedCourses;
    }
    if (purchasedCourses.isNotEmpty) {
      data['purchasedCourses'] = purchasedCourses;
    }

    return data;
  }
}
