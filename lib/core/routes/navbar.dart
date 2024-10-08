import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nova_wheels/shared/utils/extensions/context_extension.dart';

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
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: GNav(
        tabBackgroundColor: Colors.purple.withOpacity(0.1),
        style: GnavStyle.google,
        activeColor: Colors.blue,
        gap: context.width * 0.025,
        curve: Curves.linear,
        padding: EdgeInsets.all(10),
        iconSize: 20,
        haptic: true,
        rippleColor: Colors.blue.shade700.withOpacity(0.25),
        color: Colors.grey[800],
        selectedIndex: navigationShell.currentIndex,
        tabs: [
          GButton(
            text: context.localization?.home ?? "",
            icon: Icons.home,
          ),
          GButton(
            text: context.localization?.profile ?? "",
            icon: Icons.person,
          ),
          GButton(
            text: context.localization?.setting ?? "",
            icon: Icons.settings,
          ),
          GButton(
            text: context.localization?.home ?? "",
            icon: Icons.store,
          ),
          // GButton(
          //   text: context.localization?.home ?? "",
          //   icon: Icons.add,
          // ),
        ],
        onTabChange: _goBranch,
      ),
    );
  }
}
