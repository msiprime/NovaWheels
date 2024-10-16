import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/presentation/blocs/fetch_store_bloc/fetch_store_bloc.dart';

class AllStoresWidget extends StatelessWidget {
  const AllStoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<FetchStoreBloc>()..add(AllStoreFetched()),
      child: BlocBuilder<FetchStoreBloc, FetchStoreState>(
        builder: (context, state) {
          return switch (state) {
            FetchStoreInitial() => const Center(child: Text('Initializing...')),
            FetchStoreLoading() =>
              const Center(child: CircularProgressIndicator()),
            FetchStoreSuccess storeSuccess => ListView.builder(
                shrinkWrap: true,
                itemCount: storeSuccess.storeEntities.length,
                itemBuilder: (context, index) {
                  final store = storeSuccess.storeEntities[index];
                  return ListTile(
                    title: Text(store.name),
                    subtitle: Text(store.id),
                  );
                },
              ),
            FetchStoreFailure failure => Center(
                child: Text(failure.errorMessage),
              ),
          };
        },
      ),
    );
  }
}
