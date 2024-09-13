import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

//ignore: must_be_immutable
class ScaffoldWithNestedNavigation extends StatelessWidget {
  late AppLocalizations? _appLocalizations;

  ScaffoldWithNestedNavigation({
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
    _appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
              label: _appLocalizations?.home ?? "",
              icon: const Icon(Icons.home)),
          NavigationDestination(
              label: _appLocalizations?.profile ?? "",
              icon: const Icon(Icons.person_rounded)),
          NavigationDestination(
              label: _appLocalizations?.setting ?? "",
              icon: const Icon(Icons.settings)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
