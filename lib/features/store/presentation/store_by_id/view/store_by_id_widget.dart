import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/profile/presentation/extension/date_time_extension.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_store_by_id_usecase.dart';
import 'package:nova_wheels/features/store/presentation/store_by_id/bloc/store_by_id_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoreByIdWidget extends StatelessWidget {
  final String storeId;

  const StoreByIdWidget({
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
      child: StoreByIdView(
        storeId: storeId,
      ),
    );
  }
}

class StoreByIdView extends StatelessWidget {
  final String storeId;

  const StoreByIdView({
    super.key,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreByIdCubit, StoreByIdState>(
        builder: (context, state) {
      if (state is StoreByIdLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is StoreByIdLoaded) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'This vehicle is owned by this shop',
                    style: context.titleMedium,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.read<StoreByIdCubit>().fetchStoreById(storeId);
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            Tappable.scaled(
              scaleStrength: ScaleStrength.xxxs,
              onTap: () {},
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: 150,
                  width: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: state.store.profilePicture ?? '',
                        // Provide a default or empty string if null
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 40,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => const SizedBox(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.store, size: 30),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          state.store.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          state.store.createdAt?.mDY ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
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
