import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_all_stores_usecase.dart';
import 'package:nova_wheels/features/store/presentation/public/public_store/bloc/public_store_bloc.dart';
import 'package:nova_wheels/features/store/shared/store_type_enum.dart';
import 'package:nova_wheels/features/store/shared/widget/store_front_widget.dart';

class PublicStoreScreen extends StatelessWidget {
  const PublicStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicStoreBloc(
          fetchPublicStoreUseCase: sl.call<FetchPublicStoreUseCase>())
        ..add(PublicStoreFetched()),
      child: PublicStoreView(),
    );
  }
}

class PublicStoreView extends StatelessWidget {
  const PublicStoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PublicStoreBloc>().add(PublicStoreFetched());
      },
      child: AppScaffold(
          appBar: NovaWheelsAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  context.read<PublicStoreBloc>().add(PublicStoreFetched());
                },
              )
            ],
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
                        context.goNamed(Routes.userStores);
                      },
                    ),
                    Text('Stores Near You',
                        style: context.theme.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    // StoreWidget(type: FetchStoreType.allStores),
                    BlocBuilder<PublicStoreBloc, PublicStoreState>(
                      builder: (context, state) {
                        return switch (state) {
                          PublicStoreInitial() =>
                            const Center(child: CircularProgressIndicator()),
                          PublicStoreLoading() =>
                            const Center(child: CircularProgressIndicator()),
                          PublicStoreSuccess storeSuccess => ListView.builder(
                              shrinkWrap: true,
                              itemCount: storeSuccess.storeEntities.length,
                              itemBuilder: (context, index) {
                                final store = storeSuccess.storeEntities[index];
                                return StoreFrontWidget(
                                  store: store,
                                  type: FetchStoreType.allStores,
                                );
                              },
                            ),
                          PublicStoreFailure failure => Center(
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
