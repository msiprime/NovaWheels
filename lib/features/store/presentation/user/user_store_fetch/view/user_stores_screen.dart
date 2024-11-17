import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_bar.dart';
import 'package:nova_wheels/core/base_component/base/base_widgets/app_primary_button.dart';
import 'package:nova_wheels/core/routes/routes.dart';
import 'package:nova_wheels/features/store/presentation/user/user_store_fetch/bloc/user_store_fetch_bloc.dart';
import 'package:nova_wheels/features/store/shared/store_type_enum.dart';
import 'package:nova_wheels/features/store/shared/widget/store_front_widget.dart';

class UserStoresScreen extends StatelessWidget {
  const UserStoresScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserStoreFetchBloc(
        fetchUserStoreByIdUseCase: sl.call(),
        fetchUserStoreUseCase: sl.call(),
      )..add(UserStoreFetched()),
      child: const UserStoresView(),
    );
  }
}

class UserStoresView extends StatelessWidget {
  const UserStoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: NovaWheelsAppBar(
          title: 'Your Stores',
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<UserStoreFetchBloc>().add(UserStoreFetched());
              },
            ),
          ],
        ),
        body: BlocBuilder<UserStoreFetchBloc, UserStoreFetchState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  switch (state) {
                    UserStoreFetchInitial() =>
                      const Center(child: Text('Initializing...')),
                    UserStoreFetchLoading() =>
                      //TODO: create shimmer loading here
                      const Center(child: CircularProgressIndicator()),
                    UserStoreFetchSuccess storeSuccess => Expanded(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const Gap(10),
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: storeSuccess.stores.length,
                          itemBuilder: (context, index) {
                            final store = storeSuccess.stores[index];
                            return StoreFrontWidget(
                              store: store,
                              type: FetchStoreType.userStores,
                              // type: FetchStoreType.userStores,
                            );
                          },
                        ),
                      ),
                    UserStoreFetchFailure failure => Center(
                        child: Text(failure.errorMessage),
                      ),
                  },
                  AppPrimaryButton(
                    onPressed: () {
                      context.goNamed(Routes.createStore);
                    },
                    title: "Create Store",
                  ),
                ],
              ),
            );
          },
        ));
  }
}
