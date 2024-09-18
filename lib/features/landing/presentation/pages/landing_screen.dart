import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  @override
  void initState() {
    context.read<LandingBloc>().add(CountDown());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LandingBloc, LandingState>(listener: (context, state) {
        if (state.landingStatus == LandingStatus.initial) {
          context.read<LandingBloc>().add(CountDown());
        } else {
          if (state.isFirstTimer == true) {
            context.goNamed(Routes.onboarding);
          } else if (state.bearerToken != null) {
            context.goNamed(Routes.home);
          } else {
            context.goNamed(Routes.signIn);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  child: Image.asset(
                    AppAssets.novaWheelsLogo,
                    color: Colors.blueGrey,
                    colorBlendMode: BlendMode.overlay,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
