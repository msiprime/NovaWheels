part of 'fetch_store_bloc.dart';

@immutable
sealed class FetchStoreEvent {}

final class FetchStoreStarted extends FetchStoreEvent {}

final class FetchUserStoreStarted extends FetchStoreEvent {
  FetchUserStoreStarted();
}
