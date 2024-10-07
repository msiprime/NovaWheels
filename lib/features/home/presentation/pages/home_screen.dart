import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/sign_out_button.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(30),
            Text(
              'Welcome to Nova Wheels',
              style: context.titleLarge,
            ),
            LottieBuilder.asset(AppAssets.underConstructionLottie),
            const Gap(10),
            Text(
              'We are currently building our application',
              style: context.titleMedium,
            ),
            Spacer(),
            SignOutButton(),
            //Title
          ],
        ),
      ),
    );
  }
}
