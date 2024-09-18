import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:nova_wheels/shared/values/app_assets_path.dart';
import 'package:shimmer/shimmer.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.success) {
          context.goNamed(Routes.home);
        }
      },
      builder: (context, state) {
        return ActionChip(
            avatar: SvgPicture.asset(AppAssets.googleSVG),
            label: (state.status == SignInStatus.loading)
                ? textShimmer
                : const Text('Google'),
            onPressed: () {
              context.read<SignInBloc>().add(const GoogleSignInSubmitted());
            });
      },
    );
  }
}

final Shimmer textShimmer = Shimmer.fromColors(
  baseColor: Colors.red,
  highlightColor: Colors.yellow,
  child: const Text(
    'Google',
  ),
);
