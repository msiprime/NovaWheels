import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/base_setting_row.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';
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

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ChangeSetting(),
        Lottie.asset(AppAssets.lottieOnboarding1),
        const SizedBox(height: 24),
        Text(
          "Welcome to Your Ultimate Home Decor Hub!",
          style: context.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Discover the best home decor items and manage your inventory with ease.",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppAssets.lottieOnboarding2),
        const SizedBox(height: 24),
        Text(
          "Manage Your Stores with Ease",
          style: context.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Create and manage up to 5 stores effortlessly. Keep your customers informed with real-time updates.",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AppAssets.lottieOnboarding3),
        const SizedBox(height: 24),
        Text(
          "Showcase Your Unique Collection",
          style: context.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Let the world see your beautiful collections. Your stores are publicly accessible, allowing other users to explore what you offer.",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
