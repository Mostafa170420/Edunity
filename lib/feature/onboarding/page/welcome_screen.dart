import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/onboarding/model/onboarding_model.dart';
import 'package:edunity/feature/onboarding/widgets/on_boarding_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              pushWithReplacement(context, Routes.login);
            },
            label: Text('Skip'),
            icon: Icon(Icons.arrow_forward),
            iconAlignment: IconAlignment.end,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: PageView.builder(
                controller: pageController,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnBoardingWidgets(
                    onboardingPage: onboardingPages[index],
                  );
                }),
          ),
          SizedBox(height: 20),
          Flexible(
            flex: 2,
            child: SmoothPageIndicator(
              controller: pageController,
              count: onboardingPages.length,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: AppColors.primaryDarkColor,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  Padding _buildNavBar(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: (pageController.hasClients && pageController.page != 0)
                  ? () {
                      pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              label: Text('Previous'),
              icon: Icon(Icons.arrow_back_ios_new),
              iconAlignment: IconAlignment.start,
            ),
            GradientButton(
              onPressed: () {
                // Navigate to next page or main screen
                pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
                if (pageController.page == onboardingPages.length - 1) {
                  // Navigate to main screen
                  pushWithReplacement(context, Routes.login);
                }
              },
              label: 'Next',
              icon: Icon(Icons.arrow_forward_ios),
              iconAlignment: IconAlignment.end,
            )
          ],
        ));
  }
}
