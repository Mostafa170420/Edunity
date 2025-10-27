import 'package:carousel_slider/carousel_slider.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/home/presentation/model/slider_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class homeslider extends StatefulWidget {
  const homeslider({super.key});

  @override
  State<homeslider> createState() => _homesliderState();
}

class _homesliderState extends State<homeslider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [BuildSlider(), Gap(15), BuildIndicator()]);
  }

  SmoothPageIndicator BuildIndicator() {
    return SmoothPageIndicator(
      controller: PageController(initialPage: currentIndex),
      count: 4,
      effect: ExpandingDotsEffect(
        dotColor: AppColors.borderColor,
        activeDotColor: AppColors.yellowLightColor,
        dotHeight: 7,
        dotWidth: 3,
        expansionFactor: 5,
      ),
      onDotClicked: (index) {},
    );
  }

  CarouselSlider BuildSlider() {
    return CarouselSlider.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: SliderModel()),
      options: CarouselOptions(
        height: 150,
        viewportFraction: 1,
        initialPage: 0,
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
