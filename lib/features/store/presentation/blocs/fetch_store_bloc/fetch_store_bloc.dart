import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_all_stores_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_user_store_usecase.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'fetch_store_event.dart';
part 'fetch_store_state.dart';

class FetchStoreBloc extends Bloc<FetchStoreEvent, FetchStoreState> {
  final FetchUserStoreUseCase _fetchUserStoreUseCase;
  final FetchAllStoreUseCase _fetchAllStoreUseCase;

  FetchStoreBloc({
    required FetchUserStoreUseCase fetchUserStoreUseCase,
    required FetchAllStoreUseCase fetchAllStoreUseCase,
  })  : _fetchUserStoreUseCase = fetchUserStoreUseCase,
        _fetchAllStoreUseCase = fetchAllStoreUseCase,
        super(FetchStoreInitial()) {
    on<StoreFetched>(_onStoreFetched);
    // on<FetchStoreEvent>((event, emit) {});
  }

  FutureOr<void> _onStoreFetched(
      StoreFetched event, Emitter<FetchStoreState> emit) async {
    emit(FetchStoreLoading());

    switch (event.type) {
      case FetchStoreType.allStores:
        await _fetchAllStores(emit);
        break;
      case FetchStoreType.userStores:
        await _fetchUserStores(emit);
        break;
    }
  }

  Future<void> _fetchAllStores(Emitter<FetchStoreState> emit) async {
    try {
      final response = await _fetchAllStoreUseCase.call();
      response.fold(
        (l) => emit(FetchStoreFailure(errorMessage: l.message)),
        (r) => emit(FetchStoreSuccess(storeEntities: r)),
      );
    } catch (e, s) {
      emit(FetchStoreFailure(errorMessage: 'Unexpected error occurred'));

      Log.error(
          'Fetch Store Exception Occurred Error: $e \n  \n StackTrace: $s');
    }
  }

  _fetchUserStores(Emitter<FetchStoreState> emit) async {
    try {
      final response = await _fetchUserStoreUseCase.call();
      response.fold(
        (l) => emit(FetchStoreFailure(errorMessage: l.message)),
        (r) => emit(FetchStoreSuccess(storeEntities: r)),
      );
    } catch (e, s) {
      emit(FetchStoreFailure(errorMessage: 'Unexpected error occurred'));

      Log.error(
          'Fetch Store Exception Occurred Error: $e \n  \n StackTrace: $s');
    }
  }
}
