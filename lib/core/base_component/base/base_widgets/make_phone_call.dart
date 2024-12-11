import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/sl/injection_container.dart';
import '../../cubits/call_cubit.dart';

class MakePhoneCall extends StatelessWidget {
  const MakePhoneCall({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

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
                  Icons.phone,
                  color: Colors.white,
                ),
                const Gap(8),
                Text(
                  'Call',
                  style: context.theme.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          onTap: () {
            callCubit.makePhoneCall(phoneNumber);
          },
        );
      },
      bloc: callCubit,
    );
  }
}
