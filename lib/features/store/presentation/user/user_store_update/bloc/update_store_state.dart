part of 'update_store_bloc.dart';

@immutable
sealed class UpdateStoreState {}

final class UpdateStoreInitial extends UpdateStoreState {}

final class UpdateStoreLoading extends UpdateStoreState {}

final class UpdateStoreSuccess extends UpdateStoreState {
  final StoreEntity store;

  UpdateStoreSuccess({
    required this.store,
  });
}

final class UpdateStoreError extends UpdateStoreState {
  final String errorMessage;

  UpdateStoreError({
    required this.errorMessage,
  });
}

/// for deleting store

final class DeleteStoreLoading extends UpdateStoreState {}

final class DeleteStoreSuccess extends UpdateStoreState {}

final class DeleteStoreError extends UpdateStoreState {
  final String errorMessage;

  DeleteStoreError({
    required this.errorMessage,
  });
}
