import 'dart:developer';

import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/extentions/dialogs.dart';
import 'package:edunity/feature/course_details/presentation/bloc/course_bloc.dart';
import 'package:edunity/feature/course_details/presentation/bloc/course_event.dart';
import 'package:edunity/feature/course_details/presentation/bloc/course_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CourseBottomBar extends StatefulWidget {
  const CourseBottomBar({super.key, required this.courseId});
  final String courseId;

  @override
  State<CourseBottomBar> createState() => _CourseBottomBarState();
}

class _CourseBottomBarState extends State<CourseBottomBar> {
  bool isFav = false;
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CourseBloc>();
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        if (state is AddToCartSuccessState) {
          setState(() => isInCart = true);
          showMyDialoge(context, state.message ?? 'Success',
              type: DialogeType.success);
        }

        if (state is CourseErrorState) {
          showMyDialoge(context, state.message, type: DialogeType.warning);
        }
      },
      builder: (context, state) {
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
                  label: isInCart ? "Added to Cart" : "Add to Cart",
                  addedToCart: isInCart,
                  onPressed: () {
                    log('Add to Cart button pressed');
                    // Call your add to cart logic here
                    bloc.add(AddToCartEvent(widget.courseId));
                  },
                  icon: Icon(Icons.shopping_cart),
                  iconAlignment: IconAlignment.start),
            ],
          ),
        );
      },
    );
  }
}
