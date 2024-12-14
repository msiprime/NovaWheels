import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/presentation/vehicle_request_for_store/bloc/vehicle_request_for_store_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleBookingStatusWidget extends StatelessWidget {
  final String vehicleId;

  const VehicleBookingStatusWidget({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehicleRequestForStoreCubit>(
      create: (context) => VehicleRequestForStoreCubit(
        StoreRepoImpl(
          storeDataSource: StoreDataSourceImpl(
            supabaseClient: Supabase.instance.client,
          ),
        ),
      )..fetchStatusForVehicle(vehicleId: vehicleId),
      child: VehicleBookingStatusView(vehicleId: vehicleId),
    );
  }
}

class VehicleBookingStatusView extends StatelessWidget {
  final String vehicleId;

  const VehicleBookingStatusView({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleRequestForStoreCubit,
        VehicleRequestForStoreState>(builder: (context, state) {
      if (state is VehicleRequestForStoreError) {}
      if (state is VehicleRequestDetailsByVehicleIdSuccess) {
        if (state.requests.startDate != null &&
            state.requests.endDate != null) {
          return Text(
            'Booking: ${state.requests.startDate} - ${state.requests.endDate}',
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          );
        }
      }

      return const SizedBox();
    });
  }
}
