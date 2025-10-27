import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/constants/app_assets.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/model/category_model.dart';
import 'package:edunity/feature/home/presentation/model/courses_names_model.dart';
import 'package:edunity/feature/home/presentation/model/mentor_model.dart';
import 'package:edunity/feature/home/presentation/widgets/category_names_list.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_list.dart';
import 'package:edunity/feature/home/presentation/widgets/courses_names_list.dart';
import 'package:edunity/feature/home/presentation/widgets/homeslider.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:edunity/feature/home/presentation/widgets/mentor_names_list.dart';
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
              onTap: () => pushTo(context, Routes.notifications),
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
      body: SingleChildScrollView(
          child: Column(
        children: [
          Hero(
              tag: 'searchFieldHero',
              child: Material(
                color: Colors.transparent,
                child: CustomTextField(
                  controller: searchController,
                  hintText: 'Search for..',
                  readOnly: true,
                  onTap: () {
                    pushTo(context, Routes.search);
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        pushTo(context, Routes.filter);
                      },
                      icon: Image.asset(AppAssets.filter)),
                  prefixIcon: Image.asset(AppAssets.search),
                ),
              )),
          Gap(30),
          homeslider(),
          Gap(30),
          Row(
            children: [
              Hero(
                  tag: 'seeAllCategories',
                  child: Material(
                    color: Colors.transparent,
                    child: Text('Categories',
                        style: TextStyles.getTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    pushTo(context, Routes.category);
                  },
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
          CustomHorizontalListView(
            height: 30,
            items: categories,
            itemBuilder: (context, category, index) {
              return CategoryNamesList(
                categoryNamesModel: categories[index],
              );
            },
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
          CustomHorizontalListView(
            height: 30,
            items: courses,
            itemBuilder: (context, category, index) {
              return CoursesNamesList(
                coursesMmodel: courses[index],
              );
            },
          ),
          Gap(30),
          CustomHorizontalListView(
            height: 290,
            items: courses,
            courses: true,
            itemBuilder: (context, category, index) {
              return CoursesList(
                coursesModel: courses[index + 1],
              );
            },
          ),
          Gap(30),
          Row(
            children: [
              Hero(
                  tag: 'seeAllMentors',
                  child: Material(
                    color: Colors.transparent,
                    child: Text('Top Mentors',
                        style: TextStyles.getTitle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  )),
              Spacer(),
              TextButton(
                  onPressed: () {
                    pushTo(context, Routes.topMentors);
                  },
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
          CustomHorizontalListView(
            height: 100,
            items: mentors,
            itemBuilder: (context, category, index) {
              return MentorNamesList(
                mentorModel: mentors[index],
              );
            },
          ),
          Gap(100),
        ],
      )),
    );
  }
}
