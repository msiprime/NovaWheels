import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_user_store_usecase.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'fetch_store_event.dart';
part 'fetch_store_state.dart';

class FetchStoreBloc extends Bloc<FetchStoreEvent, FetchStoreState> {
  final FetchUserStoreUseCase _fetchUserStoreUseCase;

  FetchStoreBloc({required FetchUserStoreUseCase fetchUserStoreUseCase})
      : _fetchUserStoreUseCase = fetchUserStoreUseCase,
        super(FetchStoreInitial()) {
    on<FetchStoreStarted>(_onFetchStoreStarted);
    on<FetchUserStoreStarted>(_onFetchUserStoreStarted);
    on<FetchStoreEvent>((event, emit) {});
  }

  FutureOr<void> _onFetchStoreStarted(
      FetchStoreStarted event, Emitter<FetchStoreState> emit) async {}

  FutureOr<void> _onFetchUserStoreStarted(
      FetchUserStoreStarted event, Emitter<FetchStoreState> emit) async {
    emit(FetchStoreLoading());
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
