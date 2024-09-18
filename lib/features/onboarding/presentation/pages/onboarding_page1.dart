import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/base_setting_row.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ChangeSetting(),
        SizedBox(
          height: 350,
          child: Lottie.asset(
            height: 350,
            backgroundLoading: false,
            AppAssets.novaWheelsLottie,
            addRepaintBoundary: true,
            filterQuality: FilterQuality.low,
            bundle: DefaultAssetBundle.of(context),
          ),
        ).animate().fadeIn(duration: 1.seconds),
        const SizedBox(height: 24),
        Text(
          "Welcome to Nova Wheels! Where Quality Deals Spin the Wheels",
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Explore a wide range of vehicles, from new to used, to find the perfect fit for your lifestyle.",
          style: context.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
