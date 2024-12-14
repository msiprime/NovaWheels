import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/shared/widget/small_advertisement_card.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/input/vehicle_reponse_entity.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/store_vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/stream_of_store_vehicles.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/bloc/fetch_vehicle_bloc.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/view/vehicle_details_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoreAdvertisementsTab extends StatelessWidget {
  const StoreAdvertisementsTab({
    super.key,
    required this.store,
  });

  final StoreEntity store;

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
            StreamOfVehicleByStoreFetched(storeId: store.id),
          ),
        child: VehiclesByStoreIdView(storeId: store.id),
      ),
    );
  }
}

class VehiclesByStoreIdView extends StatefulWidget {
  final String storeId;

  const VehiclesByStoreIdView({
    super.key,
    required this.storeId,
  });

  @override
  State<VehiclesByStoreIdView> createState() => _VehiclesByStoreIdViewState();
}

class _VehiclesByStoreIdViewState extends State<VehiclesByStoreIdView> {
  @override
  Widget build(BuildContext context) {
    final Stream vehicleStreamFromStore = Supabase.instance.client
        .from('vehicles')
        .select()
        .eq('store_id', widget.storeId)
        .select()
        .asStream();
    return RefreshIndicator(
      onRefresh: () async {
        // context.read<FetchVehicleBloc>().add(
        //       StreamOfVehicleByStoreFetched(storeId: storeId),
        //       // VehicleByStoreFetched(
        //       //   storeId: storeId,
        //       // ),
        //     );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: vehicleStreamFromStore,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<Map<String, dynamic>>;
                final vehicles =
                    data.map((e) => VehicleResponseEntity.fromJson(e)).toList();
                return Expanded(
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
                              'storeId': widget.storeId,
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
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

//Column(
//         children: [
//           BlocBuilder<FetchVehicleBloc, FetchVehicleState>(
//             builder: (context, state) {
//               switch (state) {
//                 case FetchVehicleInitial _:
//                   return Text('Vehicle Initial');
//                 case FetchVehicleLoading _:
//                   return CircularProgressIndicator();
//                 case FetchVehicleLoaded success:
//                   return Expanded(
//                     child: ListView.separated(
//                       separatorBuilder: (context, index) => 16.gap,
//                       itemCount: success.vehicles.length,
//                       itemBuilder: (context, index) {
//                         final vehicle = success.vehicles[index];
//                         return Tappable.faded(
//                           fadeStrength: FadeStrength.sm,
//                           onTap: () {
//                             context.pushNamed(
//                               VehicleDetailsPage.routeName,
//                               extra: {
//                                 'vehicleId': vehicle.id,
//                                 'storeId': storeId,
//                               },
//                             );
//                           },
//                           child: SmallAdvertisementCard(
//                             title: vehicle.title,
//                             coverPhoto: (vehicle.images.isNotEmpty == true)
//                                 ? vehicle.images.first
//                                 : '',
//                             isForSale: vehicle.isForSale,
//                             salePrice: vehicle.salePrice,
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 case FetchVehicleError _:
//                   return Text('Vehicle Error');
//                 default:
//                   return Text('Vehicle Error');
//               }
//             },
//           ),
//         ],
//       ),
