import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_buy_rent_request/bloc/vehicle_buy_rent_request_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class RentRequestFormView extends StatefulWidget {
  const RentRequestFormView({
    super.key,
    required this.vehicleId,
    required this.storeId,
  });

  final String vehicleId;
  final String storeId;

  @override
  State<RentRequestFormView> createState() => _RentRequestFormViewState();
}

class _RentRequestFormViewState extends State<RentRequestFormView> {
  late final TextEditingController mobileNumberController;
  late final TextEditingController secondMobileNumberController;
  late final TextEditingController emailController;
  late final TextEditingController additionalDetailsController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    mobileNumberController = TextEditingController();
    secondMobileNumberController = TextEditingController();
    emailController = TextEditingController();
    additionalDetailsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    mobileNumberController.dispose();
    secondMobileNumberController.dispose();
    emailController.dispose();
    additionalDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(title: 'Request to Rent'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: BlocConsumer<VehicleBuyRentCubit, VehicleBuyRentState>(
            listener: (context, state) {
              if (state is VehicleRequestSuccess) {
                context.showSnackBar(
                  'Successfully requested to rent this vehicle.',
                  color: Colors.green,
                );
                context.pop();
                context.goNamed(Routes.home);
              } else if (state is VehicleRequestFailure) {
                context.showSnackBar(
                  'Failed to request the vehicle. Please try again. ${state.errorMessage}',
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  16.gap,
                  Text(
                    "Please fill in the form to request renting this vehicle from the store.",
                    style: context.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  24.gap,
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged:
                        (DateRangePickerSelectionChangedArgs args) {
                      if (args.value is PickerDateRange) {
                        setState(() {
                          startDate = args.value.startDate;
                          endDate = args.value.endDate;
                        });
                      }
                    },
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., 017970000',
                    labelText: 'Mobile Number',
                    // validator: InputValidators.phone,
                    controller: mobileNumberController,
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., 017970000',
                    labelText: 'Mobile Number (Optional)',
                    controller: secondMobileNumberController,
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., someone@some.com',
                    labelText: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Additional details or requests',
                    labelText: 'Additional Details (Optional)',
                    maxLines: 5,
                    style: context.bodyMedium,
                    controller: additionalDetailsController,
                  ),
                  24.gap,
                  AppPrimaryButton(
                    isLoading: state is VehicleRequestLoading,
                    onPressed: () {
                      if (startDate == null || endDate == null) {
                        context.showSnackBar(
                          'Please select a valid date range.',
                          color: Colors.red,
                        );
                        return;
                      }

                      final rentRequestEntity = VehicleBuyRentRequestEntity(
                        vehicleId: widget.vehicleId,
                        userId: Supabase.instance.client.auth.currentUser!.id,
                        storeId: widget.storeId,
                        requestType: 'rent',
                        mobileNumber: mobileNumberController.text,
                        email: emailController.text,
                        secondMobileNumber: secondMobileNumberController.text,
                        requestDate: DateTime.now().toIso8601String(),
                        status: 'pending',
                        additionalDetails: additionalDetailsController.text,
                        startDate: startDate?.toIso8601String(),
                        endDate: endDate?.toIso8601String(),
                      );

                      context.read<VehicleBuyRentCubit>().requestToRent(
                            requestEntity: rentRequestEntity,
                          );
                    },
                    title: "Submit Request",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
