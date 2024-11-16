part of 'public_store_bloc.dart';

@immutable
sealed class PublicStoreEvent {}

class PublicStoreFetched extends PublicStoreEvent {}
