import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/components/inputs/custom_text_field.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconly/iconly.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = const EdgeInsets.symmetric(horizontal: 20);
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome, Teacher',
                      style: TextStyles.getTitle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkgreyColor,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(IconlyBroken.plus, size: 28),
                          onPressed: () {
                            // Upload course action
                          },
                        ),
                        IconButton(
                          icon: const Icon(IconlyBroken.notification, size: 28),
                          onPressed: () {
                            pushTo(context, Routes.notifications);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),

                // Search Bar
                Hero(
                  tag: 'searchFieldHero',
                  child: Material(
                    color: Colors.transparent,
                    child: CustomTextField(
                      controller: searchController,
                      hintText: 'Search for students or lessons...',
                      readOnly: true,
                      onTap: () => pushTo(context, Routes.search),
                      suffixIcon: GradientButton(
                        label: '',
                        onPressed: () => pushTo(context, Routes.search),
                        width: 45,
                        borderRadius: 14,
                        icon: const Icon(
                          IconlyBroken.search,
                          color: Colors.white,
                        ),
                        iconAlignment: IconAlignment.end,
                      ),
                    ),
                  ),
                ),
                const Gap(15),

                // Other Useful Info Section
                SizedBox(
                  height: 84,
                  child: GridView.count(
                    crossAxisCount: 1,
                    scrollDirection: Axis.horizontal,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                    children: [
                      // Button 1
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(8), // smaller padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconlyBroken.activity,
                                size: 20, color: Colors.white),
                            SizedBox(height: 4),
                            Text(
                              'Upcoming Assignments',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10, // smaller font
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Button 2
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconlyBroken.calendar,
                                size: 20, color: Colors.white),
                            SizedBox(height: 4),
                            Text(
                              'Upcoming Sessions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Button 3
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconlyBroken.activity,
                                size: 20, color: Colors.white),
                            SizedBox(height: 4),
                            Text(
                              'Calendar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Button 4
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryDarkColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconlyBroken.paper,
                                size: 20, color: Colors.white),
                            SizedBox(height: 4),
                            Text(
                              'Quick Notes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(15),

                // Dashboard Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Student Requests',
                      style: TextStyles.getTitle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkgreyColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: TextStyles.getSmall(
                          fontSize: 18,
                          color: AppColors.primaryDarkColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),

                // Student Requests List (cards)
                Column(
                  children: List.generate(
                    3,
                    (index) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name and time
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.primaryDarkColor,
                                  child: const Icon(
                                    IconlyBroken.user_2,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const Gap(8),
                                Expanded(
                                  child: Text(
                                    'Saiful Islam Emon',
                                    style: TextStyles.getTitle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '13 Hours ago',
                                  style: TextStyles.getSmall(
                                      color: AppColors.greyColor),
                                ),
                              ],
                            ),
                            const Gap(6),
                            // Request description
                            Text(
                              'Need a tutor From SUST',
                              style: TextStyles.getSmall(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkgreyColor,
                              ),
                            ),
                            const Gap(8),
                            // Category / Days row
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Category: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: 'English Medium',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Days/Week: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: '3 Days',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(4),
                            // Class / Fee row
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Class: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: 'Seven',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Fee: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: '4500 Tk',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(4),
                            // Subject / Location row
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Subject: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: 'Eng, Mat, Scien',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyles.getSmall(fontSize: 17),
                                      children: [
                                        TextSpan(
                                            text: 'Location: ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.darkColor)),
                                        const TextSpan(
                                            text: 'Chawhatta',
                                            style: TextStyle(
                                                color: AppColors.darkColor)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(12),
                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Message action
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.primaryDarkColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Message',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Call action
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.greenColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Call',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
