import 'dart:developer';

import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TeacherDetailsScreen extends StatefulWidget {
  const TeacherDetailsScreen({
    super.key,
    required this.teacher,
  });

  final TeacherModel teacher;

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  List<CourseModel> courses = [];
  @override
  void initState() {
    super.initState();
    loadTeacherCourses();
  }

  loadTeacherCourses() async {
    var snapshot =
        await FirebaseProvider.getCoursesByIds(widget.teacher.uploadedCourses);

    courses = snapshot.docs
        .map((doc) => CourseModel.fromJson(doc.data() as Map<String, dynamic>,
            id: doc.id))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teacher Profile",
          style: TextStyles.getTitle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryDarkColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ======= Profile Header Card =======
            _ProfileHeader(
                teacher: widget.teacher,
                courseCount: widget.teacher.uploadedCourses.length),

            Gap(15),

            // ======= Quick Stats =======
            _TeacherStats(
              teacher: widget.teacher,
            ),

            Gap(15),

            // ======= About Section =======
            _AboutSection(bio: widget.teacher.bio),

            Gap(15),
            // ======= Contact Section =======
            _ContactSection(email: widget.teacher.email),

            Gap(15),

            // ======= Courses Section =======
            _CoursesSection(
              //wrong courses but for now it's a placeholder
              courses: courses,
              teacher: widget.teacher,
              hasCourses: widget.teacher.uploadedCourses.isNotEmpty,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------- Profile Header -----------------
class _ProfileHeader extends StatelessWidget {
  final TeacherModel teacher;
  final int courseCount;

  const _ProfileHeader({required this.teacher, required this.courseCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDarkColor.withValues(alpha: 0.15),
            AppColors.primaryLightColor.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.greyColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Profile Avatar
          CircleAvatar(
            radius: 47,
            backgroundColor: AppColors.primaryDarkColor.withValues(alpha: 0.8),
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  teacher.avatarUrl ?? AppAssets.placeholder,
                ),
              ),
            ),
          ),
          Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  teacher.name ?? "Unknown Teacher",
                  style: TextStyles.getTitle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  teacher.category ?? "No specialization",
                  style: TextStyles.getBody(
                    fontSize: 14,
                  ),
                ),
                const Gap(15),

                // Action Buttons
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to chat screen with the teacher
                        pushTo(
                          context,
                          Routes.chatScreen,
                          // extra: {
                          //   'receiverId': teacher.id,
                          //   'receiverName': teacher.name,
                          //   'receiverAvatar': teacher.avatarUrl,
                          // },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryDarkColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.message_outlined,
                                  color: Colors.white, size: 18),
                              const Gap(8),
                              Text(
                                'Message',
                                style: TextStyles.getBody(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Gap(8),
                    GestureDetector(
                      onTap: () {
                        if (courseCount > 0) {
                          // pushTo(
                          // context,
                          // Routes.teacherCourses,
                          // extra: teacher,
                          // );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text("No courses available yet"),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primaryDarkColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.library_books_outlined,
                                  color: AppColors.primaryDarkColor, size: 18),
                              //const Gap(8),
                              Text(
                                '$courseCount Courses',
                                style: TextStyles.getBody(
                                  fontSize: 14,
                                  color: AppColors.primaryDarkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ----------------- Teacher Stats -----------------
class _TeacherStats extends StatelessWidget {
  final TeacherModel teacher;

  const _TeacherStats({
    required this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            label: 'Rating',
            value: (teacher.rating ?? 0).toStringAsFixed(1),
            icon: Icons.star_rate_rounded,
            color: Colors.amber,
          ),
          _StatItem(
            label: 'Reviews',
            value: (teacher.ratingCount ?? 0).toString(),
            icon: Icons.reviews_outlined,
            color: AppColors.primaryDarkColor,
          ),
          _StatItem(
            label: 'Courses',
            value: teacher.uploadedCourses.length.toString(),
            icon: Icons.library_books_outlined,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

// ----------------- About Section -----------------
class _AboutSection extends StatelessWidget {
  final String? bio;

  const _AboutSection({required this.bio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline,
                  color: AppColors.primaryDarkColor, size: 20),
              const Gap(8),
              Text(
                'About Teacher',
                style: TextStyles.getTitle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            bio?.isNotEmpty == true && bio != 'null'
                ? bio!
                : 'This teacher hasn\'t added a bio yet. Check back later to learn more about their teaching style and experience.',
            style: TextStyles.getBody(
              fontSize: 15,
              color: AppColors.greyColor,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}

// ----------------- Contact Section -----------------
class _ContactSection extends StatelessWidget {
  final String? email;

  const _ContactSection({required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.contact_mail_outlined,
                  color: AppColors.primaryDarkColor, size: 20),
              const Gap(8),
              Text(
                'Contact Information',
                style: TextStyles.getTitle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(16),
          _ContactItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: email ?? 'Not provided',
            onTap: email != null
                ? () {
                    // Handle email tap
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

// ----------------- Courses Section -----------------
class _CoursesSection extends StatelessWidget {
  final List<CourseModel>? courses;
  final TeacherModel teacher;
  final bool hasCourses;

  const _CoursesSection({
    required this.courses,
    required this.teacher,
    required this.hasCourses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.library_books_outlined,
                      color: AppColors.primaryDarkColor, size: 20),
                  const Gap(8),
                  Text(
                    'Available Courses',
                    style: TextStyles.getTitle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (hasCourses)
                Text(
                  '${courses!.length} courses',
                  style: TextStyles.getBody(
                    color: AppColors.greyColor,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const Gap(16),

          //i dont understand this shit
          if (hasCourses)
            Column(children: [
              ListView.builder(
                itemCount: courses!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  log('Course at index $index: ${courses![index].name}');
                  return _CourseTile(course: courses![index]);
                },
              ),
            ])
          else
            Text(
              'This teacher has not uploaded any courses yet. Please check back later for updates.',
              style: TextStyles.getBody(
                fontSize: 15,
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.start,
            ),
        ],
      ),
    );
  }
}

// ----------------- Small Components -----------------

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const Gap(8),
        Text(
          value,
          style: TextStyles.getTitle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const Gap(4),
        Text(
          label,
          style: TextStyles.getBody(
            color: AppColors.greyColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: onTap != null
              ? AppColors.primaryDarkColor.withOpacity(0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.greyColor.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primaryDarkColor),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.getBody(
                      fontSize: 12,
                      color: AppColors.greyColor,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    value,
                    style: TextStyles.getBody(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.greyColor,
              ),
          ],
        ),
      ),
    );
  }
}

class _CourseTile extends StatelessWidget {
  final CourseModel course;

  const _CourseTile({required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          pushTo(context, Routes.courseDetails, extra: course);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(color: AppColors.greyColor.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  course.thumbnail ?? AppAssets.placeholder,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 70,
                      height: 70,
                      color: AppColors.greyColor.withOpacity(0.1),
                      child: Icon(Icons.photo_library_outlined,
                          color: AppColors.greyColor),
                    );
                  },
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name ?? "Untitled Course",
                      style: TextStyles.getTitle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Gap(6),
                    Text(
                      course.category ?? "General",
                      style: TextStyles.getBody(
                        color: AppColors.greyColor,
                        fontSize: 13,
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
