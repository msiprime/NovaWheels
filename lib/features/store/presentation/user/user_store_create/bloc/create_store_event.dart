part of 'create_store_bloc.dart';

@immutable
sealed class CreateStoreEvent {
  const CreateStoreEvent();
}

final class CreateStoreTapped extends CreateStoreEvent {
  final StoreCreationParams storeCreationParams;

  const CreateStoreTapped({
    required this.storeCreationParams,
  });
}
