import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextButton(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColorsMain.selectedBlue.withOpacity(0.1);
              }
              return null;
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'Reset',
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: AppColorsMain.selectedBlue,
          ),
        ),
      ),
    );
  }
}

class UrgentBackButton extends _ActionButton {
  const UrgentBackButton({
    super.key,
    super.color,
    super.style,
    super.onPressed,
  }) : super(icon: const UrgentBackButtonIcon());

  @override
  void _onPressedCallback(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.pushReplacementNamed(Routes.home);
    }
  }

  @override
  String _getTooltip(BuildContext context) {
    return MaterialLocalizations.of(context).backButtonTooltip;
  }
}

class UrgentBackButtonIcon extends StatelessWidget {
  const UrgentBackButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      const Icon(
        Icons.arrow_back_ios,
        size: 18,
        color: AppColorsMain.selectedBlue,
      ),
      Text(
        MaterialLocalizations.of(context).backButtonTooltip,
        style: context.theme.textTheme.titleMedium?.copyWith(
          color: AppColorsMain.selectedBlue,
        ),
      ),
    ]);
  }
}

abstract class _ActionButton extends StatelessWidget {
  const _ActionButton({
    super.key,
    this.color,
    required this.icon,
    required this.onPressed,
    this.style,
  });

  final Widget icon;

  final VoidCallback? onPressed;

  final Color? color;

  final ButtonStyle? style;

  String _getTooltip(BuildContext context);

  void _onPressedCallback(BuildContext context);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      visualDensity: VisualDensity.compact,
      icon: icon,
      style: style?.copyWith(
        visualDensity: VisualDensity.compact,
      ),
      color: color,
      tooltip: _getTooltip(context),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          _onPressedCallback(context);
        }
      },
    );
  }
}
