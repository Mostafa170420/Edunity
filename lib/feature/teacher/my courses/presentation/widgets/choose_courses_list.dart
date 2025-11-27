import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChooseCoursesListTeacher extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onPressed;

  const ChooseCoursesListTeacher({
    super.key,
    required this.onPressed,
    required this.selectedIndex,
  });

  @override
  State<ChooseCoursesListTeacher> createState() =>
      _ChooseCoursesListTeacherState();
}

class _ChooseCoursesListTeacherState extends State<ChooseCoursesListTeacher> {
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
                    'Recorded',
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
            Gap(10),
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () {
                    _onButtonPressed(0);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: selectedIndex == 0
                        ? AppColors.primaryDarkColor
                        : AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: Text(
                    'Live',
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
