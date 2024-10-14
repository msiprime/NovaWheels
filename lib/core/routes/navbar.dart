import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';
import 'package:nova_wheels/shared/values/app_colors.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark, //navigation bar icons' color
      ),
    );
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: GNav(
        style: GnavStyle.oldSchool,
        activeColor: AppColorsMain.colorPrimary,
        gap: context.width * 0.0005,
        curve: Curves.linear,
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.039,
          vertical: context.height * 0,
        ),
        iconSize: 20,
        haptic: true,
        color: AppColorsMain.grey,
        selectedIndex: navigationShell.currentIndex,
        tabs: [
          GButton(
            text: context.localization?.home ?? "",
            icon: Icons.house_outlined,
          ),
          GButton(
            text: "Store",
            icon: Icons.store_outlined,
          ),
          GButton(
            text: "Post Add",
            icon: Icons.add_circle_outline,
          ),
          GButton(
            text: context.localization?.profile ?? "",
            icon: Icons.person_2_outlined,
          ),
          GButton(
            text: context.localization?.setting ?? "",
            icon: Icons.settings_outlined,
          ),
        ],
        onTabChange: _goBranch,
      ),
    );
  }
}
