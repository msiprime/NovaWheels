import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/features/store/shared/widget/small_advertisement_card.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/store_vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/stream_of_store_vehicles.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/bloc/fetch_vehicle_bloc.dart';
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
                      child: SmallAdvertisementCard(
                        title: vehicle.title,
                        coverPhoto: (vehicle.images.isNotEmpty == true)
                            ? vehicle.images.first
                            : '',
                        isForSale: vehicle.isForSale,
                        salePrice: vehicle.salePrice,
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
