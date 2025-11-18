import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/bookmark/presentation/widgets/course_card_UI.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CoursesListBuilder extends StatelessWidget {
  const CoursesListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      separatorBuilder: (_, __) => const SizedBox(height: 30),
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 134,
          child: Stack(
            children: [
              CourseCardUI(),
              BookmarkIcon(
                onTap: () => _showRemoveBookmarkBottomSheet(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _showRemoveBookmarkBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (_) => Padding(
      padding: const EdgeInsets.all(34.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Remove From Bookmark?',
            style: TextStyles.getTitle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Gap(22),
          SizedBox(
            height: 134,
            child: CourseCardUI(),
          ),
          Gap(30),
          buttonAtBottom(context),
          Gap(10),
        ],
      ),
    ),
  );
}

Row buttonAtBottom(BuildContext context) {
  return Row(
    children: [
      SizedBox(
        width: 140,
        height: 60,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Cancel",
            style: TextStyles.getSmall(
              fontWeight: FontWeight.w800,
              color: AppColors.darkColor,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDarkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Gap(10),
                Flexible(
                  child: Text(
                    "Yes, Remove",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.getSmall(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryDarkColor,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
