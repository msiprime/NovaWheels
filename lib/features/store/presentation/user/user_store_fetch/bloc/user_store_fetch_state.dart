part of 'user_store_fetch_bloc.dart';

@immutable
sealed class UserStoreFetchState {}

final class UserStoreFetchInitial extends UserStoreFetchState {}

final class UserStoreFetchLoading extends UserStoreFetchState {}

final class UserStoreFetchSuccess extends UserStoreFetchState {
  final List<StoreEntity> stores;

  UserStoreFetchSuccess({
    required this.stores,
  });
}

final class UserStoreFetchFailure extends UserStoreFetchState {
  final String errorMessage;

  UserStoreFetchFailure({
    required this.errorMessage,
  });
}
