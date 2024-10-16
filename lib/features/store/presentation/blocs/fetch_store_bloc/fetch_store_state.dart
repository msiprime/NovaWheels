part of 'fetch_store_bloc.dart';

@immutable
sealed class FetchStoreState {}

final class FetchStoreInitial extends FetchStoreState {}

final class FetchStoreLoading extends FetchStoreState {}

final class FetchStoreSuccess extends FetchStoreState {
  final List<StoreEntity> storeEntities;

  FetchStoreSuccess({
    required this.storeEntities,
  });
}

final class FetchStoreFailure extends FetchStoreState {
  final String errorMessage;

  FetchStoreFailure({
    required this.errorMessage,
  });
}
