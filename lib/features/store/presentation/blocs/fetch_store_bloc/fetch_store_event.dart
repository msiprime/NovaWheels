part of 'fetch_store_bloc.dart';

@immutable
sealed class FetchStoreEvent {}

final class StoreFetched extends FetchStoreEvent {
  final FetchStoreType type;

  StoreFetched({
    required this.type,
  });
}
