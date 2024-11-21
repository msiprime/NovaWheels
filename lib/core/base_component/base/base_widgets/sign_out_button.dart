import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey.shade200,
            minVerticalPadding: 0,
            minTileHeight: 35,
            leading: const Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            dense: true,
            title: (state.status == SignInStatus.loading)
                ? const CupertinoActivityIndicator()
                : Center(
                    child: const Text(
                      'Log out',
                      style: TextStyle(fontSize: 16, color: Colors.black
                          // color: Colors.red,
                          ),
                    ),
                  ),
            onTap: () {
              context.confirmAction(
                noText: 'Cancel',
                yesText: 'Log out',
                fn: () {
                  context.read<SignInBloc>().add(const SignOutSubmitted());
                },
                title: 'Log out',
                content: 'Are you sure you want to log out?',
              );
            },
          ),
        );
      },
    );
  }
}

//            context.read<SignInBloc>().add(const SignOutSubmitted());
