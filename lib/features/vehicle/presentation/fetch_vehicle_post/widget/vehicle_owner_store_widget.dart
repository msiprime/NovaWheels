import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_store_by_id_usecase.dart';
import 'package:nova_wheels/features/store/presentation/store_by_id/bloc/store_by_id_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VehicleOwnerStoreWidget extends StatelessWidget {
  final String storeId;

  const VehicleOwnerStoreWidget({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoreByIdCubit>(
      create: (context) => StoreByIdCubit(
        storeByIdUsecase: FetchStoreByIdUseCase(
          StoreRepoImpl(
            storeDataSource: StoreDataSourceImpl(
              supabaseClient: Supabase.instance.client,
            ),
          ),
        ),
      )..fetchStoreById(storeId),
      child: VehicleOwnerStoreView(
        storeId: storeId,
      ),
    );
  }
}

class VehicleOwnerStoreView extends StatelessWidget {
  final String storeId;

  const VehicleOwnerStoreView({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreByIdCubit, StoreByIdState>(
        builder: (context, state) {
      if (state is StoreByIdLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
            strokeWidth: 0.7,
          ),
        );
      } else if (state is StoreByIdLoaded) {
        final store = state.store;
        return Row(
          children: [
            ImageAttachmentThumbnail(
              borderRadius: BorderRadius.circular(5.6),
              imageUrl: store.profilePicture ?? '',
              width: 26,
              height: 26,
              fit: BoxFit.cover,
            ),
            const Gap(4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    store.name,
                    // You can replace this with actual user info
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textScaler: const TextScaler.linear(1),
                  ),
                  Text(
                    store.email ?? '',
                    style: context.textTheme.labelSmall
                        ?.copyWith(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    textScaler: const TextScaler.linear(1),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state is StoreByIdError) {
        return Center(
          child: Text(state.message),
        );
      } else {
        return Container();
      }
    });
  }
}
