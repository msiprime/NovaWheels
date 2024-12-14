import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_buy_rent_request_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/enum/vehicle_request_type_enum.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_request_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_buy_rent_request/bloc/vehicle_buy_rent_request_cubit.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_buy_rent_request/view/vehicle_rent_request_form.dart';
import 'package:nova_wheels/shared/validators/input_validators.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleBuyRentRequestForm extends StatelessWidget {
  static const String routeName = 'vehicle-buy-rent-request-form';

  final VehicleRequestType requestType;
  final String vehicleId;
  final String storeId;

  const VehicleBuyRentRequestForm({
    super.key,
    required this.requestType,
    required this.vehicleId,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehicleBuyRentCubit>(
      create: (context) => VehicleBuyRentCubit(
        vehicleRequestUsecase: VehicleRequestUsecase(
          vehicleRepo: VehicleRepoImpl(
            vehicleDataSource: VehicleDataSourceImpl(
              supabaseClient: Supabase.instance.client,
            ),
          ),
        ),
      ),
      child: switch (requestType) {
        VehicleRequestType.buy => BuyRequestFormView(
            storeId: storeId,
            vehicleId: vehicleId,
          ),
        VehicleRequestType.rent => RentRequestFormView(
            storeId: storeId,
            vehicleId: vehicleId,
          ),
      },
    );
  }
}

class BuyRequestFormView extends StatefulWidget {
  const BuyRequestFormView({
    super.key,
    required this.vehicleId,
    required this.storeId,
  });

  final String vehicleId;
  final String storeId;

  @override
  State<BuyRequestFormView> createState() => _BuyRequestFormViewState();
}

class _BuyRequestFormViewState extends State<BuyRequestFormView> {
  late final TextEditingController nameController;
  late final TextEditingController mobileNumberController;
  late final TextEditingController secondMobileNumberController;
  late final TextEditingController emailController;
  late final TextEditingController additionalDetailsController;

  @override
  void initState() {
    nameController = TextEditingController();
    mobileNumberController = TextEditingController();
    secondMobileNumberController = TextEditingController();
    emailController = TextEditingController();
    additionalDetailsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileNumberController.dispose();
    secondMobileNumberController.dispose();
    emailController.dispose();
    additionalDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: NovaWheelsAppBar(title: 'Request to Buy'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: BlocConsumer<VehicleBuyRentCubit, VehicleBuyRentState>(
            listener: (context, state) {
              if (state is VehicleRequestSuccess) {
                context.showSnackBar(
                  'Successfully requested to buy this vehicle.',
                  color: Colors.green,
                );
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
                    "Please fill in the form to request buying this vehicle from the store.",
                    style: context.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  24.gap,
                  AppTextField.roundedBorder(
                    hintText: 'Enter Your Name',
                    labelText: 'Name',
                    controller: nameController,
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., 017970000',
                    labelText: 'Mobile Number',
                    validator: InputValidators.phone,
                    // textInputType: TextInputType.phone,
                    onChanged: (value) {
                      // Handle mobile number change
                    },
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., 017970000',
                    labelText: 'Mobile Number (Optional)',
                    // textInputType: TextInputType.phone,
                    onChanged: (value) {
                      // Handle second mobile number change
                    },
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
                    hintText: 'e.g., someone@some.com',
                    labelText: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // Handle email change
                    },
                  ),
                  16.gap,
                  AppTextField.roundedBorder(
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
                      final buyRequestEntity = VehicleBuyRentRequestEntity(
                        vehicleId: widget.vehicleId,
                        userId: Supabase.instance.client.auth.currentUser!.id,
                        storeId: widget.storeId,
                        requestType: 'buy',
                        mobileNumber: mobileNumberController.text,
                        email: emailController.text,
                        secondMobileNumber: secondMobileNumberController.text,
                        requestDate: '',
                        status: '',
                        additionalDetails: additionalDetailsController.text,
                      );

                      context.read<VehicleBuyRentCubit>().requestToBuy(
                            requestEntity: buyRequestEntity,
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
