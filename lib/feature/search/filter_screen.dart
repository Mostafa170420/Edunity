import 'dart:developer';

import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<String> subCategories = [
    '3D Design',
    'Web Development',
    '3D Animation',
    'Graphic Design',
    'SEO & Marketing',
    'Arts & Humanities',
  ];

  final List<String> levels = [
    'All Levels',
    'Beginners',
    'Intermediate',
    'Expert',
  ];

  final List<String> price = [
    'Paid',
    'Free',
  ];
  final List<String> features = [
    'All Captions',
    'Quizzes',
    'Coding Exercises',
    'Practice Tests',
  ];

  final List<String> rating = [
    '4.5 & up',
    '4.0 & up',
    '3.5 & up',
    '3.0 & up',
  ];

  final List<String> duration = [
    '0 - 2 hours',
    '3 - 6 hours',
    '7 - 16 hours',
    '17+ hours',
  ];

  final List<String> filters = [
    'subCategories',
    'levels',
    'price',
    'features',
    'rating',
    'duration',
  ];

  List<Map<String, dynamic>> get allFilters => [
        {'title': 'subCategories', 'options': subCategories},
        {'title': 'levels', 'options': levels},
        {'title': 'price', 'options': price},
        {'title': 'features', 'options': features},
        {'title': 'rating', 'options': rating},
        {'title': 'duration', 'options': duration}
      ];
  final Set<String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Filter'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedOptions.clear();
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Clear',
                style: TextStyles.getBody(
                    color: AppColors.greyColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            for (final filter in allFilters) ...[
              Text(
                '${filter['title']}:',
                style: TextStyles.getBody(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(15),
              for (final option in filter['options']) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedOptions.contains(option)) {
                        selectedOptions.remove(option);
                      } else {
                        selectedOptions.add(option);
                      }
                    });
                    log('Selected Options: $selectedOptions');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: selectedOptions.contains(option)
                                  ? AppColors.greenColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: selectedOptions.contains(option)
                                    ? AppColors.greenColor
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                            ),
                            child: selectedOptions.contains(option)
                                ? const Icon(Icons.check,
                                    size: 18, color: Colors.white)
                                : null,
                          ),
                          Gap(10),
                          Text(
                            option,
                            style: TextStyles.getBody(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ]
          ]),
        ),
      ),
    );
  }
}
