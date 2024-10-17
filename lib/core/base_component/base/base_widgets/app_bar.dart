import 'package:flutter/material.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';

import 'action_buttons.dart';

class NovaWheelsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isBackButtonEnabled;
  final Color? bgColor;
  final Color? tittleTextColor;

  const NovaWheelsAppBar({
    super.key,
    required this.title,
    this.bgColor,
    this.actions,
    this.isBackButtonEnabled = true,
    this.tittleTextColor,
  });

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    final Color selectedBlue = Color(0xff007AFF);
    ThemeData theme = Theme.of(context);

    return AppBar(
      leadingWidth: context.width * 0.25,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: isBackButtonEnabled ? const UrgentBackButton() : null,
      backgroundColor: bgColor ?? theme.appBarTheme.backgroundColor,
      automaticallyImplyLeading: isBackButtonEnabled,
      actions: actions,
      iconTheme: theme.appBarTheme.iconTheme,
      centerTitle: true,
      title: Text(
        title,
        style: context.theme.textTheme.titleMedium?.copyWith(
          // fontSize: context.width * 0.041,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
