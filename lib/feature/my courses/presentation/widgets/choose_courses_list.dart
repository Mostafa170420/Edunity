import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChooseCoursesList extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onPressed;
  final String firstLabel; // Left button (index = 1)
  final String secondLabel; // Right button (index = 0)

  const ChooseCoursesList({
    super.key,
    required this.onPressed,
    required this.selectedIndex,
    this.firstLabel = 'Ongoing',
    this.secondLabel = 'Completed',
  });

  @override
  State<ChooseCoursesList> createState() => _ChooseCoursesListState();
}

class _ChooseCoursesListState extends State<ChooseCoursesList> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant ChooseCoursesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  void _onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onPressed(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // First button (Ongoing / Live Sessions)
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () => _onButtonPressed(1),
                  style: TextButton.styleFrom(
                    backgroundColor: selectedIndex == 1
                        ? AppColors.primaryDarkColor
                        : AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    widget.firstLabel, // ✅ Dynamic label
                    style: TextStyles.getSmall(
                      color: selectedIndex == 1
                          ? AppColors.whiteColor
                          : AppColors.darkgreyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),

            // Second button (Completed / Uploaded Courses)
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () => _onButtonPressed(0),
                  style: TextButton.styleFrom(
                    backgroundColor: selectedIndex == 0
                        ? AppColors.primaryDarkColor
                        : AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    widget.secondLabel, // ✅ Dynamic label
                    style: TextStyles.getSmall(
                      color: selectedIndex == 0
                          ? AppColors.whiteColor
                          : AppColors.darkgreyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
