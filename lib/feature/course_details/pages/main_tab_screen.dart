import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/course_details/pages/curriculum_page.dart';
import 'package:edunity/feature/course_details/pages/overview_page.dart';
import 'package:edunity/feature/course_details/pages/reviews_page.dart';
import 'package:edunity/feature/course_details/widgets/course_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  @override
  Widget build(BuildContext context) {
    int rating = 4;
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.upload))
          ],
        ),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(child: _headerImage()),
                SliverToBoxAdapter(child: _courseDetails(rating)),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.white,
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
            body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                OverviewPage(),
                CurriculumPage(),
                ReviewsPage(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CourseBottomBar(),
      ),
    );
  }

  Padding _courseDetails(int rating) {
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
                    "Mathematics",
                    style: TextStyle(
                        color: AppColors.primaryDarkColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              "Advanced Calculus Mastery",
              style: TextStyles.getBody(fontSize: 19),
            ),
            const Gap(20),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipOval(
                        child: Image.asset(AppAssets.emptyUser),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Dr. Sarah Ahmed",
                          style: TextStyles.getSmall(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            return Icon(
                              index < rating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            );
                          }),
                        ),
                        Row(
                          children: [
                            const Text("4.8"),
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
                            const Text("2,500 Students")
                          ],
                        ),
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
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const Text("4.9"),
                const Gap(5),
                const Text("(324 Reviews)")
              ],
            ),
            const Gap(15),
            Row(
              children: const [
                Icon(Icons.people_alt_outlined),
                Gap(8),
                Text("1,240 Students"),
                Gap(20),
                Icon(Icons.access_time_outlined),
                Gap(8),
                Text("12 hours"),
                Gap(20),
                Icon(Icons.language_outlined),
                Gap(8),
                Text("English")
              ],
            )
          ],
        ),
      ),
    );
  }

  Stack _headerImage() {
    return Stack(children: [
      Image.asset(AppAssets.mathBlackBoard),
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
