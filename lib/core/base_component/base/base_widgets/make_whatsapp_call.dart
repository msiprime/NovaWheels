import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../config/sl/injection_container.dart';
import '../../cubits/call_cubit.dart';

class MakeWhatsAppCall extends StatelessWidget {
  const MakeWhatsAppCall({
    super.key,
    required this.whatsappNumber,
  });

  final String whatsappNumber;

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
          onTap: () {
            callCubit.openWhatsApp(
              whatsAppNumber: whatsappNumber,
              message: 'Hello, I am interested in your property',
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.white,
                ),
                const Gap(8),
                Text(
                  'WhatsApp',
                  style: context.theme.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
      },
      bloc: callCubit,
    );
  }
}
