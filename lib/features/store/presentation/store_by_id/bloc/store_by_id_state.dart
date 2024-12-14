part of 'store_by_id_cubit.dart';

@immutable
sealed class StoreByIdState {}

final class StoreByIdInitial extends StoreByIdState {}

final class StoreByIdLoading extends StoreByIdState {}

final class StoreByIdLoaded extends StoreByIdState {
  final StoreEntity store;

  StoreByIdLoaded({
    required this.store,
  });
}

final class StoreByIdError extends StoreByIdState {
  final String message;

  StoreByIdError({
    required this.message,
  });
}
