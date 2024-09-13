import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';
import 'package:nova_wheels/shared/values/app_values.dart';

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
            color: AppColors.colorPrimary,
          )
        : SizedBox(
            height: height,
            width: width ?? context.width, // MediaQuery.of(context).size.width,
            child: CupertinoButton(
              padding: textStyle != null
                  ? const EdgeInsets.symmetric(
                      horizontal: 10, vertical: AppValues.halfPadding)
                  : null,
              // color: Theme.of(context).colorScheme.primary,
              color: context.theme.colorScheme.primary,
              onPressed:
                  isEnabled == null || isEnabled == true ? onPressed : null,
              child: textStyle == null
                  ? FittedBox(
                      child: Text(
                        title,
                        style: textStyle ??
                            TextStyle(
                              color: context.theme.colorScheme.surface,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  : Text(
                      title,
                      style: textStyle,
                    ),
            ),
          );
  }
}
