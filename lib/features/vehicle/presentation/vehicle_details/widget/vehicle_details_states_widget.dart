import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/shimmers/vehicle_details_shimmer.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/cubit/vehicle_details_cubit/vehicle_details_cubit.dart';

/// Shimmer loading widget
/// When the vehicle details are loading
class LoadingVehicleDetailsShimmer extends StatelessWidget {
  const LoadingVehicleDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const VehicleDetailsLoadingShimmer(),
    );
  }
}

/// Error widget
/// When there is an error loading the vehicle details
class ErrorVehicleDetails extends StatelessWidget {
  const ErrorVehicleDetails({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 80, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

/// Initial widget
/// When the vehicle details are loading
class InitialVehicleDetails extends StatelessWidget {
  const InitialVehicleDetails({
    super.key,
    required this.vehicleId,
  });

  final String vehicleId;

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
