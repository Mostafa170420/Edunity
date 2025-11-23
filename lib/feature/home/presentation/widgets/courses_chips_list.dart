import 'package:edunity/core/models/course_category_model.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/core/utils/text_styles.dart';
import 'package:edunity/feature/home/presentation/widgets/custom_list_view_buillder.dart';
import 'package:flutter/material.dart';

typedef OnSelectionChanged = void Function(int index);

class CategoriesChipsList extends StatefulWidget {
  final List<CategoryModel> CourseModel;
  final OnSelectionChanged? onSelectionChanged;
  final bool isContained;
  final bool? includeAll;
  final int? initialSelectedIndex;

  const CategoriesChipsList({
    super.key,
    required this.CourseModel,
    this.onSelectionChanged,
    this.isContained = true,
    this.initialSelectedIndex,
    this.includeAll = false,
  });

  @override
  State<CategoriesChipsList> createState() => _CategoriesChipsListState();
}

class _CategoriesChipsListState extends State<CategoriesChipsList> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex ?? -1;
  }

  @override
  void didUpdateWidget(covariant CategoriesChipsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialSelectedIndex != oldWidget.initialSelectedIndex) {
      _selectedIndex = widget.initialSelectedIndex ?? -1;
    }
  }

  void _handleTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onSelectionChanged?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHorizontalListView(
      height: 30,
      items: widget.CourseModel,
      itemBuilder: (context, item, index) {
        final bool isSelected = index == _selectedIndex;

        final Color textColor = isSelected
            ? (widget.isContained
                ? AppColors.whiteColor
                : AppColors.primaryDarkColor)
            : AppColors.greyColor;

        final FontWeight fontWeight = isSelected
            ? (widget.isContained ? FontWeight.w500 : FontWeight.w700)
            : FontWeight.w400;

        final Widget chipContent = Text(
          widget.CourseModel[index].name,
          style: TextStyles.getBody(
            fontWeight: fontWeight,
            fontSize: 13,
            color: textColor,
          ),
        );

        Widget chipWidget;

        if (widget.isContained) {
          if (widget.includeAll == true) {
            if (index == 0) {
              chipWidget = Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? AppColors.primaryDarkColor
                      : AppColors.greyColor.withOpacity(0.2),
                ),
                child: Text(
                  'All',
                  style: TextStyles.getBody(
                    fontWeight: fontWeight,
                    fontSize: 13,
                    color: textColor,
                  ),
                ),
              );
              return widget.isContained
                  ? InkWell(
                      onTap: () => _handleTap(index),
                      child: chipWidget,
                    )
                  : GestureDetector(
                      onTap: () => _handleTap(index),
                      child: chipWidget,
                    );
            }
          }
          chipWidget = Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? AppColors.primaryDarkColor
                  : AppColors.greyColor.withOpacity(0.2),
            ),
            child: chipContent,
          );
        } else {
          chipWidget = Padding(
            padding: const EdgeInsets.only(right: 20),
            child: chipContent,
          );
        }

        return widget.isContained
            ? InkWell(
                onTap: () => _handleTap(index),
                child: chipWidget,
              )
            : GestureDetector(
                onTap: () => _handleTap(index),
                child: chipWidget,
              );
      },
    );
  }
}
