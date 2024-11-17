part of 'update_store_bloc.dart';

@immutable
sealed class UpdateStoreEvent {}

class DeleteStorePressed extends UpdateStoreEvent {
  final String storeId;

  DeleteStorePressed({required this.storeId});
}

class UpdateStoreStarted extends UpdateStoreEvent {
  final StoreEntity storeEntity;

  UpdateStoreStarted({required this.storeEntity});
}
