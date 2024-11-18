import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/vehicle/presentation/post_vehicle_ad/widget/chip_filter_section.dart';
import 'package:shared/shared.dart';

import '../../shared/enums/enums.dart';

class PostVehicleAdScreen extends StatelessWidget {
  static const String routeName = '/add-vehicle-post';

  const PostVehicleAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddVehicleView();
  }
}

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({super.key});

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  late final TextEditingController dummyController;

  @override
  void initState() {
    dummyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(title: 'Post Your Vehicle'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VehiclePostTextFieldForm(),
              10.gap,
              ChipFilterSection<VehicleFuelType>(
                chipLabel: 'Select Fuel Type',
                values: VehicleFuelType.values,
                onSelected: (value) {
                  print(value);
                  dummyController.text = value.name;
                  logI(dummyController.text);
                },
              ),
              5.gap,
              ChipFilterSection<VehicleTransmissionType>(
                chipLabel: 'Select Transmission Type',
                values: VehicleTransmissionType.values,
                onSelected: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VehiclePostTextFieldForm extends StatelessWidget {
  const VehiclePostTextFieldForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: Toyota Corolla 2019',
        ),
        10.gap,
        Text(
          'Description of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          // hintText: 'Enter Description',
          maxLines: 5,
        ),
        10.gap,
        Text(
          'Price of your vehicle (in TK)',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: 10000',
          onChanged: (value) {},
        ),
        10.gap,
        Text(
          'Brand of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: Toyota',
        ),
        10.gap,
        Text(
          'Model of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: Corolla',
        ),
        10.gap,
        Text(
          'Year of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: 2019',
        ),
        10.gap,
        Text(
          'Location of your vehicle',
          style: context.titleMedium,
        ),
        5.gap,
        AppTextField.roundedBorder(
          hintText: 'eg: Dhaka, Bangladesh',
        ),
      ],
    );
  }
}
