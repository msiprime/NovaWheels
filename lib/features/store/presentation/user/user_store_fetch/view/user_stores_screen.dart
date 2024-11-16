import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/config/sl/injection_container.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_user_store_usecase.dart';
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
        fetchUserStoreUseCase: FetchUserStoreUseCase(
          StoreRepoImpl(
            storeDataSource: StoreDataSourceImpl(
              supabaseClient: sl.get(),
            ),
          ),
        ),
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
        body: BlocBuilder<UserStoreFetchBloc, UserStoreFetchState>(
      builder: (context, state) {
        return switch (state) {
          UserStoreFetchInitial() =>
            const Center(child: Text('Initializing...')),
          UserStoreFetchLoading() =>
            //TODO: create shimmer loading here
            const Center(child: CircularProgressIndicator()),
          UserStoreFetchSuccess storeSuccess => ListView.separated(
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
          UserStoreFetchFailure failure => Center(
              child: Text(failure.errorMessage),
            ),
        };
      },
    ));
  }
}
