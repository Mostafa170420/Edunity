import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChooseCoursesList extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onPressed;

  const ChooseCoursesList({
    super.key,
    required this.onPressed,
    required this.selectedIndex,
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
            // ✅ Completed Button
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () {
                    _onButtonPressed(0);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: selectedIndex == 0
                        ? AppColors.greenColor
                        : AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    'Completed',
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

            Gap(10),

            // ✅ Ongoing Button
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () => _onButtonPressed(1),
                  style: TextButton.styleFrom(
                    backgroundColor: selectedIndex == 1
                        ? AppColors.greenColor
                        : AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    'Ongoing',
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
          ],
        ),
      ],
    );
  }
}
