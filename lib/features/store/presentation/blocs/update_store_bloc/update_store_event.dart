part of 'update_store_bloc.dart';

@immutable
sealed class UpdateStoreEvent {}

class DeleteStoreStarted extends UpdateStoreEvent {
  final String storeId;

  DeleteStoreStarted({required this.storeId});
}
