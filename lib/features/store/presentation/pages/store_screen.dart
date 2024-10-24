import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/presentation/blocs/fetch_store_bloc/fetch_store_bloc.dart';
import 'package:nova_wheels/features/store/presentation/widgets/my_store_widget.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<FetchStoreBloc>()
        ..add(StoreFetched(type: FetchStoreType.allStores)),
      child: StoreView(),
    );
  }
}

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<FetchStoreBloc>()
            .add(StoreFetched(type: FetchStoreType.allStores));
      },
      child: AppScaffold(
          appBar: NovaWheelsAppBar(
            title: 'Store',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tappable.faded(
                      throttle: false,
                      throttleDuration: Duration(seconds: 5),
                      fadeStrength: FadeStrength.md,
                      borderRadius: 8,
                      backgroundColor: context.theme.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4),
                        child: Text('Manage your store here',
                            style: context.theme.textTheme.bodyLarge?.copyWith(
                                color: context.reversedAdaptiveColor)),
                      ),
                      onTap: () async {
                        context.goNamed(Routes.manageStore);
                      },
                    ),
                    Text('Stores Near You',
                        style: context.theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    // StoreWidget(type: FetchStoreType.allStores),
                    BlocBuilder<FetchStoreBloc, FetchStoreState>(
                      builder: (context, state) {
                        return switch (state) {
                          FetchStoreInitial() =>
                            const Center(child: Text('Initializing...')),
                          FetchStoreLoading() =>
                            const Center(child: CircularProgressIndicator()),
                          FetchStoreSuccess storeSuccess => ListView.builder(
                              shrinkWrap: true,
                              itemCount: storeSuccess.storeEntities.length,
                              itemBuilder: (context, index) {
                                final store = storeSuccess.storeEntities[index];
                                return StoreFrontWidget(
                                    store: store,
                                    type: FetchStoreType.allStores);
                              },
                            ),
                          FetchStoreFailure failure => Center(
                              child: Text(failure.errorMessage),
                            ),
                        };
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
