import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final bool? isEnabled;
  final bool? isLoading;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isEnabled,
    this.isLoading,
    this.height,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const CircularProgressIndicator(
            color: AppColorsMain.colorPrimary,
          )
        : SizedBox(
            height: height ?? 48,
            width: width ?? double.infinity,
            child: Tappable.scaled(
              scaleStrength: ScaleStrength.xxs,
              borderRadius: 8,
              backgroundColor: context.theme.primaryColor,
              onTap: onPressed,
              child: Center(
                child: Text(title,
                    style: textStyle ??
                        context.theme.textTheme.titleMedium
                            ?.copyWith(color: context.reversedAdaptiveColor)),
              ),
            ),
          );
  }
}
