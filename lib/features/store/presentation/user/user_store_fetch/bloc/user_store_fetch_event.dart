part of 'user_store_fetch_bloc.dart';

@immutable
sealed class UserStoreFetchEvent {}

class UserStoreFetched extends UserStoreFetchEvent {}
