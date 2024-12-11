import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_by_id_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/cubit/vehicle_details_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleDetailsPage extends StatelessWidget {
  const VehicleDetailsPage({
    super.key,
    required this.vehicleId,
  });

  final String vehicleId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehicleDetailsCubit(
        vehicleByIdUsecase: VehicleByIdUsecase(
          vehicleRepo: VehicleRepoImpl(
            vehicleDataSource: VehicleDataSourceImpl(
              supabaseClient: Supabase.instance.client,
            ),
          ),
        ),
      ),
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
    return AppScaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Vehicle Details'),
          expandedHeight: 200,
          // collapsedHeight: 100,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.red,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<VehicleDetailsCubit, VehicleDetailsState>(
            builder: (context, state) => switch (state) {
              VehicleDetailsLoading() => _LoadingVehicleDetailsShimmer(),
              VehicleDetailsLoaded loaded =>
                _VehicleLoaded(vehicle: loaded.vehicle),
              VehicleDetailsError() => _ErrorVehicleDetails(),
              _ => const _InitialVehicleDetails(),
            },
          ),
        ),
      ],
    ));
  }
}

/// Vehicle loaded widget
/// When the vehicle details are loaded
class _VehicleLoaded extends StatelessWidget {
  const _VehicleLoaded({required this.vehicle});

  final VehicleResponseEntity vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(vehicle.brand ?? ''),
        Text(vehicle.model ?? ''),
        Text(vehicle.year.toString()),
        Text(vehicle.rentPrice.toString()),
        Text(vehicle.salePrice.toString()),
        Text(vehicle.status),
        Text(vehicle.location ?? ''),
        Text(vehicle.description ?? ''),
        Text(vehicle.createdAt.toString()),
        Text(vehicle.updatedAt.toString()),
      ],
    );
  }
}

/// Shimmer loading widget
/// When the vehicle details are loading
class _LoadingVehicleDetailsShimmer extends StatelessWidget {
  const _LoadingVehicleDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }
}

/// Error widget
/// When there is an error loading the vehicle details
class _ErrorVehicleDetails extends StatelessWidget {
  const _ErrorVehicleDetails();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error loading vehicle details'),
    );
  }
}

/// Initial widget
/// When the vehicle details are loading
class _InitialVehicleDetails extends StatelessWidget {
  const _InitialVehicleDetails();

  @override
  Widget build(BuildContext context) {
    context.read<VehicleDetailsCubit>().fetchVehicleById(vehicleId);
    return const Center(
      child: CupertinoActivityIndicator(
        color: Colors.red,
        radius: 40,
      ),
    );
  }
}
