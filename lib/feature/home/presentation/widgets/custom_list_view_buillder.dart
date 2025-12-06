import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomHorizontalListView<T> extends StatelessWidget {
  final double height;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final bool courses;
  final double? padding;

  const CustomHorizontalListView({
    super.key,
    required this.height,
    required this.items,
    required this.itemBuilder,
    this.courses = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: courses ? items.length - 1 : 10,
        padding: EdgeInsets.symmetric(horizontal: padding ?? 22),
        itemBuilder: (context, index) {
          final item = items[index];
          return itemBuilder(context, item, index);
        },
        separatorBuilder: (context, index) => Gap(15),
      ),
    );
  }
}
