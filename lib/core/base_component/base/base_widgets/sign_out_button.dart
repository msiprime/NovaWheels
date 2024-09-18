import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.loggedOut) {
          context.goNamed(Routes.signIn);
        }
      },
      builder: (context, state) {
        return FilledButton(
          onPressed: () {
            context.read<SignInBloc>().add(const SignOutSubmitted());
          },
          child: (state.status == SignInStatus.loading)
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text('Sign Out'),
        );
      },
    );
  }
}
