import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';

class IconAndCount extends StatelessWidget {
  const IconAndCount({
    super.key,
    required this.icon,
    required this.count,
    this.iconWidget,
  });

  final dynamic count;
  final String icon;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: count != null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget ?? SvgPicture.asset(icon, height: context.width * 0.04),
          const Gap(5),
          Text(count.toString(), style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
