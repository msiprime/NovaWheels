import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/shared/widget/small_advertisement_card.dart';
import 'package:nova_wheels/features/vehicle/presentation/blocs/vehicle_bloc.dart';

class StoreAdvertisementsTab extends StatelessWidget {
  const StoreAdvertisementsTab({
    super.key,
    required this.store,
  });

  final StoreEntity store;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => 16.gap,
                itemCount: 10,
                itemBuilder: (context, index) =>
                    UserStoreAdvertisement2(storeId: store.id),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserStoreAdvertisement extends StatelessWidget {
  const UserStoreAdvertisement({
    super.key,
    required this.storeId,
  });

  final String storeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl.get<VehicleBloc>()..add(VehicleByStoreFetched(storeId: storeId)),
      child: AppScaffold(
        body: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            return switch (state) {
              VehicleInitial() =>
                const Center(child: CircularProgressIndicator()),
              VehicleLoading() =>
                const Center(child: CircularProgressIndicator()),
              VehicleError() => Center(child: Text('message')),
              VehicleLoaded() => SmallAdvertisementCard(
                  title: 'Honda Civic 2022',
                  coverPhoto: 'https://example.com/image.jpg',
                  isForRent: true,
                  isForSale: true,
                  rentPrice: '50/day',
                  salePrice: '20,000',
                )
            };
          },
        ),
      ),
    );
  }
}

class UserStoreAdvertisement2 extends StatelessWidget {
  const UserStoreAdvertisement2({super.key, required String storeId});

  @override
  Widget build(BuildContext context) {
    return SmallAdvertisementCard(
      title: 'Honda Civic 2022',
      coverPhoto: 'https://i.ibb.co.com/P62fbsV/rent-a-car-banner1.jpg',
      isForSale: true,
      salePrice: '20,000',
    );
  }
}
