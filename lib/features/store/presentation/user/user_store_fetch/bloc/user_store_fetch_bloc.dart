import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_store_by_id_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_user_store_usecase.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'user_store_fetch_event.dart';
part 'user_store_fetch_state.dart';

class UserStoreFetchBloc
    extends Bloc<UserStoreFetchEvent, UserStoreFetchState> {
  final FetchUserStoreUseCase _fetchUserStoreUseCase;
  final FetchUserStoreByIdUseCase _fetchUserStoreByIdUseCase;

  UserStoreFetchBloc({
    required FetchUserStoreUseCase fetchUserStoreUseCase,
    required FetchUserStoreByIdUseCase fetchUserStoreByIdUseCase,
  })  : _fetchUserStoreUseCase = fetchUserStoreUseCase,
        _fetchUserStoreByIdUseCase = fetchUserStoreByIdUseCase,
        super(UserStoreFetchInitial()) {
    on<UserStoreFetched>(_onUserStoreFetched);
    on<UserStoreByIdFetched>(_onUserStoreByIdFetched);
  }

  FutureOr<void> _onUserStoreFetched(
      UserStoreFetched event, Emitter<UserStoreFetchState> emit) async {
    emit(UserStoreFetchLoading());
    try {
      final response = await _fetchUserStoreUseCase.call();
      response.fold(
        (l) {
          Log.error('Fetch Store Exception Occurred Error: ${l.message}');
          emit(UserStoreFetchFailure(errorMessage: l.message));
        },
        (r) => emit(UserStoreFetchSuccess(stores: r)),
      );
    } catch (e, s) {
      emit(UserStoreFetchFailure(errorMessage: 'Unexpected error occurred'));

      Log.error(
          'Fetch Store Exception Occurred Error: $e \n  \n StackTrace: $s');
    }
  }

  FutureOr<void> _onUserStoreByIdFetched(
      UserStoreByIdFetched event, Emitter<UserStoreFetchState> emit) async {
    emit(UserStoreFetchLoading());
    try {
      final response =
          await _fetchUserStoreByIdUseCase.call(storeId: event.storeId);
      response.fold(
        (l) {
          Log.error('Fetch Store Exception Occurred Error: ${l.message}');
          emit(UserStoreFetchFailure(errorMessage: l.message));
        },
        (r) => emit(UserStoreFetchSuccess(stores: r)),
      );
    } catch (e, s) {
      emit(UserStoreFetchFailure(errorMessage: 'Unexpected error occurred'));

      Log.error(
          'Fetch Store Exception Occurred Error: $e \n  \n StackTrace: $s');
    }
  }
}
