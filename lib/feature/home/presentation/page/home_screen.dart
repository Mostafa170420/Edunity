import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:edunity/feature/home/presentation/model/mentor_model.dart';
import 'package:edunity/feature/home/presentation/widgets/category_list.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_list.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_names_list.dart';
import 'package:edunity/feature/home/presentation/widgets/homeslider.dart';
import 'package:edunity/feature/home/presentation/widgets/top_mentor_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Alex',
                    style: TextStyles.getTitle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Gap(5),
                  Text(
                    'What Would you like to learn Today?\nSearch Below.',
                    style: TextStyles.getSmall(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () =>pushTo(context, Routes.notifications),
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.greenColor, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppAssets.bell),
                  )),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              CustomTextField(
                controller: searchController,
                hintText: 'Search for..',
                suffixIcon: IconButton(
                  icon: Image.asset(AppAssets.filter),
                  onPressed: () {},
                ),
                prefixIcon: Image.asset(AppAssets.search),
              ),
              Gap(30),
              homeslider(),
              Gap(30),
              Row(
                children: [
                  Text('Categories',
                      style: TextStyles.getTitle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'SEE ALL >',
                        style: TextStyles.getBody(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDarkColor),
                      ))
                ],
              ),
              Gap(10),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    var category = categories[index];
                    return CategoryList(
                      category_model: category,
                    );
                  },
                  separatorBuilder: (context, index) => Gap(15),
                ),
              ),
              Row(
                children: [
                  Text('Polupar Courses',
                      style: TextStyles.getTitle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'SEE ALL >',
                        style: TextStyles.getBody(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDarkColor),
                      ))
                ],
              ),
              Gap(10),
              SizedBox(
                height: 35,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    var course = courses[index];
                    return CoursesNamesList(
                      courses_model: course,
                    );
                  },
                  separatorBuilder: (context, index) => Gap(15),
                ),
              ),
              Gap(30),
              SizedBox(
                height: 260,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    var course = courses[index + 1];
                    return CoursesList(
                      courses_model: course,
                    );
                  },
                  separatorBuilder: (context, index) => Gap(15),
                ),
              ),
              Gap(30),
              Row(
                children: [
                  Text('Top Mentors',
                      style: TextStyles.getTitle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'SEE ALL >',
                        style: TextStyles.getBody(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDarkColor),
                      ))
                ],
              ),
              Gap(15),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mentors.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mentor = mentors[index];
                    return TopMentorList(
                      mentor_model: mentor,
                    );
                  },
                  separatorBuilder: (context, index) => Gap(15),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
