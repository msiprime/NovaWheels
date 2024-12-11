import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/sl/injection_container.dart';
import '../../cubits/call_cubit.dart';

class MakeEmailCall extends StatelessWidget {
  const MakeEmailCall({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    final callCubit = sl.get<CallCubit>();
    return BlocConsumer<CallCubit, CallState>(
      listener: (context, state) {
        if (state == CallState.error) {
          context.showSnackBar('Failed to make call');
        }
      },
      builder: (context, state) {
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                const Gap(8),
                Text(
                  'Email',
                  style: context.theme.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          onTap: () async {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: email,
            );
            if (await canLaunchUrl(emailUri)) {
              await launchUrl(emailUri);
              print("Email app opened successfully!");
            } else {
              print("Could not open email app.");
            }
          },
        );
      },
      bloc: callCubit,
    );
  }
}
