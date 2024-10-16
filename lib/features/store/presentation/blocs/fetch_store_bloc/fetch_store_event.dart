part of 'fetch_store_bloc.dart';

@immutable
sealed class FetchStoreEvent {}

final class AllStoreFetched extends FetchStoreEvent {}

final class UserStoreFetched extends FetchStoreEvent {
  UserStoreFetched();
}
