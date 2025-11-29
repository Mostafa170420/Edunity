import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CourseBottomBar extends StatefulWidget {
  const CourseBottomBar({super.key});

  @override
  State<CourseBottomBar> createState() => _CourseBottomBarState();
}

class _CourseBottomBarState extends State<CourseBottomBar> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Price section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "\$89",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "One-time payment",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Gap(10)],
          ),
          GradientButton(
              label: "Add to Cart",
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              iconAlignment: IconAlignment.start),
        ],
      ),
    );
  }
}
