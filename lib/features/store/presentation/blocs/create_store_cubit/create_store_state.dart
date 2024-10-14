part of 'create_store_cubit.dart';

@immutable
sealed class CreateStoreState {
  const CreateStoreState();
}

final class CreateStoreInitial extends CreateStoreState {
  const CreateStoreInitial();
}

final class CreateStoreLoading extends CreateStoreState {
  const CreateStoreLoading();
}

final class CreateStoreSuccess extends CreateStoreState {
  final StoreEntity storeEntity;

  const CreateStoreSuccess({
    required this.storeEntity,
  });
}

final class CreateStoreFailure extends CreateStoreState {
  final String errorMessage;

  const CreateStoreFailure({
    required this.errorMessage,
  });
}
