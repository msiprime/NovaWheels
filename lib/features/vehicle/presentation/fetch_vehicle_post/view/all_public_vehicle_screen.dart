import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/store_vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/stream_of_store_vehicles.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/bloc/fetch_vehicle_bloc.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/widget/vehicle_booking_widget.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/widget/vehicle_owner_store_widget.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/view/vehicle_details_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AllPublicVehicleScreen extends StatelessWidget {
  static const String routeName = 'all-public-vehicle';

  const AllPublicVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => VehicleRepoImpl(
        vehicleDataSource: VehicleDataSourceImpl(
          supabaseClient: Supabase.instance.client,
        ),
      ),
      child: BlocProvider(
        create: (context) => FetchVehicleBloc(
          vehicleUseCase: VehicleUseCase(
            vehicleRepo: context.read<VehicleRepoImpl>(),
          ),
          storeVehicleUsecase: VehicleByStoreUsecase(
            vehicleRepo: context.read<VehicleRepoImpl>(),
          ),
          streamOfStoreVehiclesUsecase: StreamOfStoreVehiclesUsecase(
            vehicleRepo: context.read<VehicleRepoImpl>(),
          ),
        )..add(
            AllVehicleFetched(),
          ),
        child: AllPublicVehicleScreenView(),
      ),
    );
  }
}

class AllPublicVehicleScreenView extends StatelessWidget {
  const AllPublicVehicleScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: const NovaWheelsAppBar(title: 'Explore All The Vehicles'),
      body: BlocBuilder<FetchVehicleBloc, FetchVehicleState>(
        builder: (context, state) {
          if (state is FetchVehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchVehicleLoaded) {
            final vehicles = state.vehicles;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FetchVehicleBloc>().add(
                      AllVehicleFetched(),
                    );
              },
              child: Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => 16.gap,
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = vehicles[index];
                    return Tappable.faded(
                      fadeStrength: FadeStrength.sm,
                      onTap: () {
                        context.pushNamed(
                          VehicleDetailsPage.routeName,
                          extra: {
                            'vehicleId': vehicle.id,
                            'storeId': vehicle.storeId,
                          },
                        );
                      },
                      child: SmallAdvertisementCard2(
                        vehicle: vehicle,
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is FetchVehicleError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class SmallAdvertisementCard2 extends StatelessWidget {
  const SmallAdvertisementCard2({
    super.key,
    required this.vehicle,
  });

  final VehicleResponseEntity vehicle;

  @override
  Widget build(BuildContext context) {
    final tags = [
      if (vehicle.isForRent) 'For Rent',
      if (vehicle.isForSale) 'For Sale',
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.theme.colorScheme.surface, // Background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Photo and Tags
          Stack(
            children: [
              ImageAttachmentThumbnail(
                borderRadius: BorderRadius.zero,
                imageUrl: vehicle.images.isNotEmpty ? vehicle.images.first : '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Wrap(
                  spacing: 4,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDarkBlue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tag,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),

          // Title, Price, and Status
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle.title,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                ),
                const Gap(4),
                Text(
                  _buildPriceText(),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textScaler: const TextScaler.linear(1),
                ),
                const Gap(8),
                // Vehicle Status and Rental Info
                if (vehicle.status == 'sold' || vehicle.status == 'rented')
                  Text(
                    'Status: ${vehicle.status.capitalize}',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                VehicleBookingStatusWidget(vehicleId: vehicle.id),
                8.gap,
                VehicleOwnerStoreWidget(
                  storeId: vehicle.storeId,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildPriceText() {
    final prices = [
      if (vehicle.isForRent && vehicle.rentPrice != null)
        'Rent: \$${vehicle.rentPrice!}',
      if (vehicle.isForSale && vehicle.salePrice != null)
        'Sale: \$${vehicle.salePrice!}',
    ];
    return prices.join(' | ');
  }
}
