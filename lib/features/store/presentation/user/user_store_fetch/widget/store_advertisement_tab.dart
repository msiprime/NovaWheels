import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/shared/widget/small_advertisement_card.dart';
import 'package:nova_wheels/features/vehicle/presentation/fetch_vehicle_post/bloc/fetch_vehicle_bloc.dart';
import 'package:nova_wheels/features/vehicle/presentation/vehicle_details/view/vehicle_details_page.dart';
import 'package:shared/shared.dart';

class StoreAdvertisementsTab extends StatelessWidget {
  const StoreAdvertisementsTab({
    super.key,
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    // Used Bloc Provider Here before, same issue
    //ab9b74ab-0d57-44b5-84f3-aba6550ec0c8
    logE('Store Advertisements Tab ${store.id}');
    return VehiclesByStoreIdView(
      storeId: store.id,
    );
  }
}

class VehiclesByStoreIdView extends StatelessWidget {
  final String storeId;

  const VehiclesByStoreIdView({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FetchVehicleBloc, FetchVehicleState>(
          bloc: sl.get<FetchVehicleBloc>()
            ..add(StreamOfVehicleByStoreFetched(storeId: storeId)),
          builder: (context, state) {
            switch (state) {
              case FetchVehicleInitial _:
                return Text('Vehicle Initial');
              case FetchVehicleLoading _:
                return CircularProgressIndicator();
              case FetchVehicleLoaded success:
                return Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 16.gap,
                    itemCount: success.vehicles.length,
                    itemBuilder: (context, index) => Tappable.faded(
                      fadeStrength: FadeStrength.sm,
                      onTap: () {
                        context.pushNamed(
                          VehicleDetailsPage.routeName,
                          extra: {
                            'vehicleId': success.vehicles[index].id,
                            'storeId': storeId,
                          },
                        );
                      },
                      child: SmallAdvertisementCard(
                        title: success.vehicles[index].title,
                        coverPhoto:
                            (success.vehicles[index].images.isNotEmpty == true)
                                ? success.vehicles[index].images.first
                                : '',
                        isForSale: success.vehicles[index].isForSale,
                        salePrice: success.vehicles[index].salePrice,
                      ),
                    ),
                  ),
                );
              case FetchVehicleError _:
                return Text('Vehicle Error');
              default:
                return Text('Vehicle Error');
            }
          },
        ),
      ],
    );
  }
}
