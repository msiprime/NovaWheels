import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/profile/presentation/extension/date_time_extension.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/enum/vehicle_request_type_enum.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_by_id_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_buy_rent_request/view/vehicle_buy_request_form.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/cubit/vehicle_details_cubit.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/widget/vehicle_details_states_widget.dart';
import 'package:nova_wheels/features/vehicle/presentation/widgets/availability_chip.dart';
import 'package:nova_wheels/features/vehicle/presentation/widgets/vehicle_status_chip.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({
    super.key,
    required this.vehicleId,
    required this.storeId,
  });

  final String vehicleId;
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<VehicleBuyRentCubit>(
        //   create: (context) => VehicleBuyRentCubit(),
        // ),
        BlocProvider<VehicleDetailsCubit>(
          create: (context) => VehicleDetailsCubit(
            vehicleByIdUsecase: VehicleByIdUsecase(
              vehicleRepo: VehicleRepoImpl(
                vehicleDataSource: VehicleDataSourceImpl(
                  supabaseClient: Supabase.instance.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: VehicleDetailsView(vehicleId: vehicleId),
    );
  }
}

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({
    super.key,
    required this.vehicleId,
  });

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleDetailsCubit, VehicleDetailsState>(
      builder: (context, state) => switch (state) {
        VehicleDetailsLoading() => LoadingVehicleDetailsShimmer(),
        VehicleDetailsLoaded loaded => _VehicleLoaded(vehicle: loaded.vehicle),
        VehicleDetailsError error =>
          ErrorVehicleDetails(errorMessage: error.message),
        _ => InitialVehicleDetails(vehicleId: vehicleId),
      },
    );
  }
}

/// Vehicle loaded widget
/// When the vehicle details are loaded
class _VehicleLoaded extends StatelessWidget {
  const _VehicleLoaded({required this.vehicle});

  final VehicleResponseEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<VehicleDetailsCubit>().fetchVehicleById(vehicle.id);
      },
      child: AppScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showRequestOptions(context),
          autofocus: true,
          backgroundColor: Colors.black.withOpacity(0.8),
          mini: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            FontAwesomeIcons.carOn,
            color: Colors.orange,
          ),
        ),
        appBar: NovaWheelsAppBar(title: 'Vehicle Details'),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppCarouselSlider(
                imageUrls: vehicle.images,
                height: 350,
                radius: 0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          vehicle.description ?? 'No description provided.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        // const Divider(height: 32),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Availability:',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              VehicleStatusChip(
                                status: vehicle.status,
                              )
                            ],
                          ),
                        ),
                        _buildDetailRow('Price:', vehicle.salePrice ?? 'N/A'),
                        _buildDetailRow('Rent:', vehicle.rentPrice ?? 'N/A'),
                        _buildDetailRow('Year:', vehicle.year ?? 'Unknown'),
                        _buildDetailRow(
                            'Mileage:', vehicle.mileage ?? 'Unknown'),
                        _buildDetailRow(
                            'Fuel Type:', vehicle.fuelType ?? 'Unknown'),
                        _buildDetailRow('Brand', vehicle.brand ?? 'Unknown'),
                        _buildDetailRow('Model:', vehicle.model ?? 'Unknown'),
                        _buildDetailRow("Updated At:", vehicle.updatedAt.mDY),
                        // _buildDetailRow("Created At:", vehicle.createdAt.mDY),
                        const Divider(height: 32),
                        // AvailabilityWidget(vehicle: vehicle),
                        GalleryWidget(vehicle: vehicle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRequestOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Request to Buy'),
                onTap: () {
                  context.pushNamed(
                    VehicleBuyRentRequestForm.routeName,
                    extra: {
                      'requestType': VehicleRequestType.buy,
                      'vehicleId': vehicle.id,
                      'storeId': vehicle.storeId,
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.car_rental),
                title: const Text('Request to Rent'),
                onTap: () {
                  context.pushNamed(
                    VehicleBuyRentRequestForm.routeName,
                    extra: {
                      'requestType': VehicleRequestType.rent,
                      'vehicleId': vehicle.id,
                      'storeId': vehicle.storeId,
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class AvailabilityWidget extends StatelessWidget {
  const AvailabilityWidget({
    super.key,
    required this.vehicle,
  });

  final VehicleResponseEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: vehicle.isForRent
          ? AvailabilityChip(
              label: 'Available for Rent',
              isAvailable: vehicle.isForRent,
            )
          : vehicle.isForSale
              ? AvailabilityChip(
                  label: 'Available for Sale',
                  isAvailable: vehicle.isForSale,
                )
              : AvailabilityChip(
                  label: 'Not Available',
                  isAvailable: false,
                ),
    );
  }
}

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    super.key,
    required this.vehicle,
  });

  final VehicleResponseEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: vehicle.images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  vehicle.images[index],
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
