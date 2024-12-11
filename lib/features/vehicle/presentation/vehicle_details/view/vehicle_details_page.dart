import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const VehicleDetailsView();
  }
}

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Container(
      color: Colors.red,
    ));
  }
}
