import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/vehicle/presentation/blocs/vehicle_bloc.dart';

class AllVehiclesListWidget extends StatelessWidget {
  const AllVehiclesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      builder: (context, state) {
        if (state is VehicleLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final vehicle = state.vehicles[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(vehicle.model ?? ''),
                  Text(vehicle.year.toString()),
                  Text(vehicle.price.toString()),
                  Text(vehicle.rentPrice.toString()),
                  Text(vehicle.id ?? ''),
                  Text(vehicle.createdAt.toString()),
                  Text(vehicle.updatedAt.toString()),
                  Text(vehicle.description.toString()),
                  Text(vehicle.vehicleCategory.toString()),
                  Text(vehicle.storeId.toString()),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(20),
            itemCount: state.vehicles.length,
          );
        }

        if (state is VehicleError) {
          return Center(child: Text(state.message));
        }
        if (state is VehicleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return const SizedBox.shrink();
      },
      listener: (context, state) {},
      bloc: sl.get<VehicleBloc>()..add(AllVehicleFetched()),
    );
  }
}
