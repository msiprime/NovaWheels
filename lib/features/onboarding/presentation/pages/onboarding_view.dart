import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/onboarding/presentation/pages/onboarding_page1.dart';
import 'package:nova_wheels/features/onboarding/presentation/pages/onboarding_page2.dart';
import 'package:nova_wheels/features/onboarding/presentation/pages/onboarding_page3.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends HookWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  currentPage.value = index;
                },
                children: const [
                  OnBoardingPage1(),
                  OnBoardingPage2(),
                  OnBoardingPage3(),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                currentPage.value == 2
                    ? FilledButton(
                        style: ButtonStyle(
                          minimumSize: WidgetStateProperty.all(
                            const Size(35, 30),
                          ),
                        ),
                        onPressed: () {
                          CacheService.instance.storeIfUserFirstTimer(false);
                          context.goNamed(Routes.signIn);
                        },
                        child: const Text('Next'),
                      )
                        .animate()
                        .slideX(duration: 500.ms, begin: 0.09)
                        .fadeIn(duration: 200.ms)
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: context.theme.primaryColor,
                            paintStyle: PaintingStyle.fill,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
