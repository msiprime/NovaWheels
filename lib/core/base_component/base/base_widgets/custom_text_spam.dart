import 'package:flutter/material.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class CustomTextSpam extends StatelessWidget {
  final String startingValue;
  final String modifyValue;
  final String lastValue;

  const CustomTextSpam(
      {super.key,
      required this.startingValue,
      required this.modifyValue,
      required this.lastValue});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: startingValue,
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: modifyValue,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColorsMain.colorPrimary,
            ),
          ),
          TextSpan(
            text: lastValue,
          ),
        ],
      ),
    );
  }
}
