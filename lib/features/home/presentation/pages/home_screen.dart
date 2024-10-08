import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/sign_out_button.dart';
import 'package:nova_wheels/features/vehicle/presentation/widgets/all_vehicles_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(30),
              Text(
                'Welcome to Nova Wheels',
                style: context.titleLarge,
              ),
              Expanded(child: AllVehiclesListWidget()),
              SignOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
