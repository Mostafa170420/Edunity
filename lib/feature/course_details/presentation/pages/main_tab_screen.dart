import 'dart:developer';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/services/firebase/firebase_provider.dart';
import 'package:edunity/core/services/local/shared_pref.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/auth/data/models/teacher_model.dart';
import 'package:edunity/feature/course_details/presentation/pages/curriculum_page.dart';
import 'package:edunity/feature/course_details/presentation/pages/overview_page.dart';
import 'package:edunity/feature/course_details/presentation/pages/reviews_page.dart';
import 'package:edunity/feature/course_details/presentation/widgets/course_bottom_bar.dart';
import 'package:edunity/feature/home/data/model/course_model.dart';
import 'package:edunity/core/services/bookmark/bookmark_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key, required this.course});
  final CourseModel course;

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  bool isBookmarked = false;
  TeacherModel? teacherData;

  @override
  void initState() {
    super.initState();
    isBookmarked = SharedPref.getIsBookmarked(widget.course.id ?? '') ?? false;
    loadTeacherData();
  }

  Future<void> loadTeacherData() async {
    var snapshot =
        await FirebaseProvider.getTeacherByID(widget.course.instructorId ?? '');

    var data = snapshot.data() as Map<String, dynamic>;

    setState(() {
      teacherData = TeacherModel.fromJson(
        data,
        snapshot.id,
      );
    });

    log('Teacher Data Loaded: $teacherData');
  }

  @override
  Widget build(BuildContext context) {
    double rating = widget.course.rating ?? 0;
    double teacherRating = teacherData?.rating ?? 0;
    String? duration = widget.course.duration;
    String? language = widget.course.language;
    String? courseRating = widget.course.rating.toString();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: isBookmarked ? Colors.amber : AppColors.greyColor,
              ),
              onPressed: () async {
                log('Bookmark button pressed');
                setState(() {
                  isBookmarked = !isBookmarked;
                  SharedPref.setIsBookmarked(
                      widget.course.id ?? '', isBookmarked);
                });
                await BookmarkService.bookmarkCourses(
                    isBookmarked: isBookmarked,
                    courseId: widget.course.id ?? '');
              },
            )
          ],
        ),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: _headerImage()),
                SliverToBoxAdapter(
                    child: _courseDetails(teacherRating, rating, duration,
                        language, courseRating)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color:
                          AppColors.logoBackgroundColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.logoBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Curriculum'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                OverviewPage(course: widget.course),
                CurriculumPage(
                  course: widget.course,
                ),
                ReviewsPage(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CourseBottomBar(courseId: widget.course.id ?? ''),
      ),
    );
  }

  Padding _courseDetails(double teacherRating, double rating, String? duration,
      String? language, String? courseRating) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 239, 254),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.primaryDarkColor, width: 1)),
                  child: Text(
                    widget.course.category ?? "Non-categorized",
                    style: TextStyle(
                        color: AppColors.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              widget.course.name ?? "N/A",
              style: TextStyles.getBody(fontSize: 19),
              maxLines: 2,
            ),
            const Gap(20),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    pushTo(context, Routes.teacherDetails, extra: teacherData);
                  },
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipOval(
                      child: Image.network(
                        teacherData?.avatarUrl ??
                            'https://res.cloudinary.com/dltddu8ah/image/upload/v1764956666/images_plg7xd.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.55),
                      child: Text(
                        widget.course.instructor ?? "N/A",
                        style: TextStyles.getSmall(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            if (index < teacherRating.floor()) {
                              // full star
                              return Icon(Icons.star,
                                  color: Colors.amber, size: 20);
                            } else if (index < teacherRating &&
                                teacherRating - teacherRating.floor() >= 0.5) {
                              // half star
                              return Icon(Icons.star_half,
                                  color: Colors.amber, size: 20);
                            } else {
                              // empty star
                              return Icon(Icons.star_border,
                                  color: Colors.amber, size: 20);
                            }
                          }),
                        ),
                        Text('${teacherData?.rating ?? ''}'),
                        const Gap(8),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Gap(8),
                        const Text("2,500 Students"),
                      ],
                    )
                  ],
                )
              ],
            ),
            const Gap(15),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(5, (index) {
                    if (index < rating.floor()) {
                      // full star
                      return Icon(Icons.star, color: Colors.amber, size: 20);
                    } else if (index < rating &&
                        rating - rating.floor() >= 0.5) {
                      // half star
                      return Icon(Icons.star_half,
                          color: Colors.amber, size: 20);
                    } else {
                      // empty star
                      return Icon(Icons.star_border,
                          color: Colors.amber, size: 20);
                    }
                  }),
                ),
                Text(courseRating ?? "N/A"),
                const Gap(5),
                const Text("(324 Reviews)")
              ],
            ),
            const Gap(15),
            Row(
              children: [
                Icon(Icons.people_alt_outlined),
                Gap(8),
                Text("1,240 Students"),
                Gap(20),
                Icon(Icons.access_time_outlined),
                Gap(8),
                Text(duration ?? "N/A"),
                Gap(20),
                Icon(Icons.language_outlined),
                Gap(8),
                Text(language ?? "N/A")
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack _headerImage() {
    return Stack(children: [
      Image.network(
        widget.course.thumbnail ?? "",
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      ),
      //Image.asset(AppAssets.mathBlackBoard),
      Positioned(
          bottom: 20,
          left: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: AppColors.redColor,
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              "31% OFF",
              style: TextStyle(color: AppColors.cardColor),
            ),
          )),
      Positioned(
        top: 20,
        right: 20,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_arrow_outlined),
                Gap(10),
                Text("Preview")
              ],
            )),
      ),
    ]);
  }
}
