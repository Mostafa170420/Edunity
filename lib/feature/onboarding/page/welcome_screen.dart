// Import necessary packages and widgets for the welcome/onboarding screen.
import 'package:edunity/components/buttons/gradient_button.dart';
import 'package:edunity/core/routes/navigation.dart';
import 'package:edunity/core/routes/routes.dart';
import 'package:edunity/core/utils/colors.dart';
import 'package:edunity/feature/onboarding/model/onboarding_model.dart';
import 'package:edunity/feature/onboarding/widgets/on_boarding_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// The `WelcomeScreen` is a stateful widget that guides the user through a series of
/// onboarding pages. It uses a `PageView` to display different introductory screens.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // `currentPage` keeps track of the currently displayed page index.
  int currentPage = 0;
  // `pageController` manages the `PageView` and allows for programmatic scrolling.
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    // A listener is added to the pageController to update the `currentPage` state
    // whenever the user scrolls to a new page.
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
          // A "Skip" button that allows users to bypass the onboarding process.
          TextButton.icon(
            onPressed: () {
              pushWithReplacement(context, Routes.login);
            },
            label: const Text('Skip'),
            icon: const Icon(Icons.arrow_forward),
            iconAlignment: IconAlignment.end,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The `PageView` builds the onboarding screens dynamically from the `onboardingPages` list.
          Flexible(
            flex: 2,
            child: PageView.builder(
                controller: pageController,
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  // The `OnBoardingWidgets` is a reusable widget for displaying each page's content.
                  return OnBoardingWidgets(
                    onboardingPage: onboardingPages[index],
                  );
                }),
          ),
          const SizedBox(height: 20),
          // `SmoothPageIndicator` displays a visual indicator of the current page.
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
      // The navigation bar at the bottom contains "Previous" and "Next" buttons.
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  /// Builds the bottom navigation bar with "Previous" and "Next" buttons.
  Padding _buildNavBar(BuildContext context) {
    // Determines if the "Next" button should navigate to the login screen.
    final bool isLastPage = currentPage == onboardingPages.length - 1;

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // The "Previous" button is enabled only if it's not the first page.
            TextButton.icon(
              onPressed: (currentPage != 0)
                  ? () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null, // Disabled on the first page.
              label: const Text('Previous'),
              icon: const Icon(Icons.arrow_back_ios_new),
              iconAlignment: IconAlignment.start,
            ),
            // The "Next" button navigates to the next page or to the login screen on the last page.
            GradientButton(
              onPressed: () {
                if (isLastPage) {
                  // If it's the last page, navigate to the login screen.
                  pushWithReplacement(context, Routes.login);
                } else {
                  // Otherwise, go to the next onboarding page.
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              label: isLastPage ? 'Get Started' : 'Next',
              icon: const Icon(Icons.arrow_forward_ios),
              iconAlignment: IconAlignment.end,
            )
          ],
        ));
  }
}
