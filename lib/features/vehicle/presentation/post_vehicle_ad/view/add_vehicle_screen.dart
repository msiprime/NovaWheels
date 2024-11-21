import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_post_input.dart';
import 'package:nova_wheels/features/vehicle/presentation/post_vehicle_ad/bloc/post_vehicle_bloc.dart';
import 'package:nova_wheels/features/vehicle/presentation/post_vehicle_ad/widget/chip_filter_section.dart';
import 'package:nova_wheels/features/vehicle/presentation/post_vehicle_ad/widget/multiple_image_picker_widget.dart';
import 'package:nova_wheels/features/vehicle/presentation/post_vehicle_ad/widget/store_selector_widget.dart';
import 'package:nova_wheels/features/vehicle/presentation/shared/enums/enums.dart';
import 'package:nova_wheels/features/vehicle/presentation/shared/enums/vehicle_type.dart';
import 'package:shared/shared.dart';

class PostVehicleAdScreen extends StatelessWidget {
  static const String routeName = '/add-vehicle-post';

  const PostVehicleAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<PostVehicleBloc>(),
      child: AddVehicleView(),
    );
  }
}

class AddVehicleView extends StatefulWidget {
  const AddVehicleView({super.key});

  @override
  State<AddVehicleView> createState() => _AddVehicleViewState();
}

class _AddVehicleViewState extends State<AddVehicleView> {
  late final TextEditingController fuelTypeController;
  late final TextEditingController transmissionTypeController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController sellPriceController;
  late final TextEditingController rentPriceController;
  late final TextEditingController brandController;
  late final TextEditingController modelController;
  late final TextEditingController yearController;
  late final TextEditingController locationController;
  late final TextEditingController storeIdController;
  late final TextEditingController vehicleTypeController;
  List<String> finalImageUrls = [];

  @override
  void initState() {
    _initControllers();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(title: 'Post Your Vehicle'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: BlocConsumer<PostVehicleBloc, PostVehicleState>(
            listener: (context, state) {
              if (state is PostVehicleError) {
                context.showSnackBar(state.message);
              } else if (state is PostVehicleLoaded) {
                context.showSnackBar('Vehicle posted successfully');
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Images of your vehicle',
                    style: context.titleMedium,
                  ),
                  SizedBox(
                    height: 100,
                    child: MultipleImagePickerWidget(
                      onImagesUpdated: (imageUrls) {
                        finalImageUrls = imageUrls.map((e) => e ?? '').toList();
                      },
                    ),
                  ),
                  VehiclePostTextFieldForm(
                    titleController: titleController,
                    descriptionController: descriptionController,
                    sellPriceController: sellPriceController,
                    rentPriceController: rentPriceController,
                    brandController: brandController,
                    modelController: modelController,
                    yearController: yearController,
                    locationController: locationController,
                    fuelTypeController: fuelTypeController,
                    transmissionTypeController: transmissionTypeController,
                    vehicleTypeController: vehicleTypeController,
                  ),
                  10.gap,

                  /// Select a Store to post your vehicle

                  10.gap,
                  StoreSelectorWidget(
                    onSelected: (storeId) {
                      if (storeId == null) {
                        storeIdController.text = '';
                        logE('No store selected');
                      } else {
                        logE(storeId);
                        storeIdController.text = storeId;
                      }
                    },
                  ),

                  10.gap,
                  AppPrimaryButton(
                    isLoading: state is PostVehicleLoading,
                    onPressed: () {
                      if (titleController.text.isEmpty) {
                        context.showSnackBar('Title cannot be empty');
                        return;
                      }

                      if (storeIdController.text.isEmpty) {
                        context.showSnackBar('Please select a store');
                        return;
                      }
                      // Determine if it's for rent or for sale
                      bool isForRent =
                          vehicleTypeController.text == VehicleType.rent.name;
                      bool isForSale =
                          vehicleTypeController.text == VehicleType.sell.name;

                      if (!isForRent && !isForSale) {
                        context.showSnackBar('Please select vehicle type');
                        return;
                      }

                      if (!isForRent) {
                        rentPriceController.clear();
                      } else if (!isForSale) {
                        sellPriceController.clear();
                      }
                      // Check if Rent Price or Sale Price is provided based on the type
                      if (isForRent && rentPriceController.text.isEmpty) {
                        context.showSnackBar(
                            'Rent price cannot be empty for rent vehicles');
                        return;
                      } else if (isForSale &&
                          sellPriceController.text.isEmpty) {
                        context.showSnackBar(
                            'Sale price cannot be empty for sale vehicles');
                        return;
                      }

                      if (fuelTypeController.text.isEmpty) {
                        context.showSnackBar('Please select fuel type');
                        return;
                      }
                      logE(' Title: ${titleController.text}, '
                          '\n Description: ${descriptionController.text}, '
                          '\n Is for rent: $isForRent, '
                          '\n Is for sale: $isForSale, '
                          '\n Rent Price: ${rentPriceController.text}, '
                          '\n Sell Price: ${sellPriceController.text}, '
                          '\n Brand: ${brandController.text}, '
                          '\n Model: ${modelController.text}, '
                          '\n Year: ${yearController.text}, '
                          '\n Location: ${locationController.text}, '
                          '\n Fuel Type: ${fuelTypeController.text}, '
                          '\n Transmission Type: ${transmissionTypeController.text}, '
                          '\n Images: $finalImageUrls'
                          '\n Vehicle Type: ${vehicleTypeController.text}');

                      // Proceed with your post request or API call here

                      context.read<PostVehicleBloc>().add(VehiclePostRequested(
                              vehicleEntity: VehicleRequestEntity(
                            status: 'available',
                            title: titleController.text,
                            description: descriptionController.text,
                            isForRent: isForRent,
                            isForSale: isForSale,
                            rentPrice: rentPriceController.text,
                            salePrice: sellPriceController.text,
                            storeId: storeIdController.text,
                            images: finalImageUrls,
                            year: yearController.text,
                            location: locationController.text,
                            fuelType: fuelTypeController.text,
                            brand: brandController.text,
                            model: modelController.text,
                          )));

                      //clear all the fields

                      titleController.clear();
                      descriptionController.clear();
                      sellPriceController.clear();
                      rentPriceController.clear();
                      brandController.clear();
                      modelController.clear();
                      yearController.clear();
                      locationController.clear();
                      fuelTypeController.clear();
                      transmissionTypeController.clear();
                      vehicleTypeController.clear();
                      finalImageUrls.clear();
                    },
                    title: 'Post Ad',
                  ),
                  50.gap,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _initControllers() {
    fuelTypeController = TextEditingController();
    transmissionTypeController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    sellPriceController = TextEditingController();
    rentPriceController = TextEditingController();
    brandController = TextEditingController();
    modelController = TextEditingController();
    yearController = TextEditingController();
    locationController = TextEditingController();
    storeIdController = TextEditingController();
    vehicleTypeController = TextEditingController();
  }

  void _disposeControllers() {
    fuelTypeController.dispose();
    transmissionTypeController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    sellPriceController.dispose();
    rentPriceController.dispose();
    brandController.dispose();
    modelController.dispose();
    yearController.dispose();
    locationController.dispose();
    storeIdController.dispose();
    vehicleTypeController.dispose();
  }
}

class VehiclePostTextFieldForm extends StatelessWidget {
  const VehiclePostTextFieldForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.sellPriceController,
    required this.rentPriceController,
    required this.brandController,
    required this.modelController,
    required this.yearController,
    required this.locationController,
    required this.fuelTypeController,
    required this.transmissionTypeController,
    required this.vehicleTypeController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController sellPriceController;
  final TextEditingController rentPriceController;
  final TextEditingController brandController;
  final TextEditingController modelController;
  final TextEditingController yearController;
  final TextEditingController locationController;
  final TextEditingController fuelTypeController;
  final TextEditingController transmissionTypeController;
  final TextEditingController vehicleTypeController;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    ValueNotifier<VehicleType?> selectedVehicleTypeNotifier =
        ValueNotifier(VehicleType.sell);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Ad Title',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            controller: titleController,
            hintText: 'eg: Toyota Corolla 2019',
            maxLength: 100,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Title cannot be empty';
              }
              return null;
            },
          ),
          Text(
            'Description of your vehicle',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            hintText: 'Give broad description for your vehicle',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            controller: descriptionController,
            maxLines: 5,
          ),
          10.gap,
          ChipFilterSection<VehicleType>(
            chipLabel: 'Vehicle is for (default sell)',
            values: VehicleType.values,
            onSelected: (value) {
              selectedVehicleTypeNotifier.value = value;
              vehicleTypeController.text = value.name;
            },
          ),
          ValueListenableBuilder(
              valueListenable: selectedVehicleTypeNotifier,
              builder: (context, value, child) {
                return switch (selectedVehicleTypeNotifier.value) {
                  VehicleType.sell => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selling price of your vehicle (in TK)',
                          style: context.titleMedium,
                        ),
                        5.gap,
                        AppTextField.roundedBorder(
                          controller: sellPriceController,
                          hintText: 'eg: 10000',
                          textInputType: TextInputType.number,
                        )
                      ],
                    ),
                  VehicleType.rent => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rent Price of your vehicle (in TK)',
                          style: context.titleMedium,
                        ),
                        5.gap,
                        AppTextField.roundedBorder(
                          textInputType: TextInputType.number,
                          controller: rentPriceController,
                          hintText: 'eg: 10000',
                        ),
                      ],
                    ),
                  null => Text(
                      'Please Choose Vehicle Type',
                      style: context.titleMedium,
                    ),
                };
              }),
          10.gap,
          Text(
            'Brand of your vehicle',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            controller: brandController,
            hintText: 'eg: Toyota',
          ),
          10.gap,
          Text(
            'Model of your vehicle',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            controller: modelController,
            hintText: 'eg: Corolla',
          ),
          10.gap,
          Text(
            'Year of your vehicle',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            controller: yearController,
            hintText: 'eg: 2019',
            textInputType: TextInputType.number,
          ),
          5.gap,
          ChipFilterSection<VehicleFuelType>(
            chipLabel: 'Select Fuel Type',
            values: VehicleFuelType.values,
            onSelected: (value) {
              fuelTypeController.text = value.name;
            },
          ),
          5.gap,
          ChipFilterSection<VehicleTransmissionType>(
            chipLabel: 'Select Transmission Type',
            values: VehicleTransmissionType.values,
            onSelected: (value) {
              transmissionTypeController.text = value.name;
            },
          ),
          10.gap,
          Text(
            'Location of your vehicle',
            style: context.titleMedium,
          ),
          5.gap,
          AppTextField.roundedBorder(
            controller: locationController,
            hintText: 'eg: Dhaka, Bangladesh',
          ),
        ],
      ),
    );
  }
}
