part of 'public_store_bloc.dart';

@immutable
sealed class PublicStoreState {}

final class PublicStoreInitial extends PublicStoreState {}

final class PublicStoreLoading extends PublicStoreState {}

final class PublicStoreSuccess extends PublicStoreState {
  final List<StoreEntity> storeEntities;

  PublicStoreSuccess({
    required this.storeEntities,
  });
}

final class PublicStoreFailure extends PublicStoreState {
  final String errorMessage;

  PublicStoreFailure({
    required this.errorMessage,
  });
}
