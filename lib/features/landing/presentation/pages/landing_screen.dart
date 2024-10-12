import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/landing/presentation/blocs/landing_bloc.dart';
import 'package:nova_wheels/features/landing/presentation/blocs/landing_event.dart';
import 'package:nova_wheels/features/landing/presentation/blocs/landing_state.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late Future<LottieComposition> _lottieComposition;

  @override
  void initState() {
    super.initState();
    context.read<LandingBloc>().add(CountDown());

    // Preload the Lottie animation
    _lottieComposition = _loadLottie();
  }

  // Function to load the Lottie asset from bytes
  Future<LottieComposition> _loadLottie() async {
    final ByteData data = await rootBundle.load(AppAssets.novaWheelsLottie);
    return await LottieComposition.fromBytes(data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LottieComposition>(
        future: _lottieComposition,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading animation.'));
          }
          if (snapshot.hasData) {
            return BlocConsumer<LandingBloc, LandingState>(
              listener: (context, state) {
                if (state.landingStatus == LandingStatus.initial) {
                  context.read<LandingBloc>().add(CountDown());
                } else {
                  if (state.isFirstTimer == true) {
                    context
                        .goNamed(Routes.onboarding); // Navigation is immediate
                  } else if (state.bearerToken != null) {
                    context.goNamed(Routes.home);
                  } else {
                    context.goNamed(Routes.signIn);
                  }
                }
              },
              builder: (context, state) {
                return _buildLandingScaffold(context);
              },
            );
          } else {
            return _buildLandingScaffold(context);
          }
        },
      ),
    );
  }

  Scaffold _buildLandingScaffold(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: SizedBox(
                child: Image.asset(
                  AppAssets.logoNoBackGroundPng,
                ).animate().scaleXY(delay: 200.ms, duration: 1.seconds),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
