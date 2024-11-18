import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';

class PostVehicleAdScreen extends StatelessWidget {
  static const String routeName = '/add-vehicle-post';

  const PostVehicleAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddVehicleView();
  }
}

class AddVehicleView extends StatelessWidget {
  const AddVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(title: 'Post Your Vehicle'),
      body: Column(
        children: [],
      ),
    );
  }
}
