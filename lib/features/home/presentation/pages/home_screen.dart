import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/sign_out_button.dart';
import 'package:nova_wheels/features/vehicle/presentation/widgets/all_vehicles_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Text('Welcome to Nova Wheels!'),
        titleTextStyle: context.titleLarge,
        // centerTitle: true,
      ),
      drawer: const Drawer(
        child: Text('Drawer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: AllVehiclesListWidget()),
              SignOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
