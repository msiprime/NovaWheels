import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_all_stores_usecase.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'public_store_event.dart';
part 'public_store_state.dart';

class PublicStoreBloc extends Bloc<PublicStoreEvent, PublicStoreState> {
  final FetchPublicStoreUseCase _fetchPublicStoreUseCase;

  PublicStoreBloc({
    required FetchPublicStoreUseCase fetchPublicStoreUseCase,
  })  : _fetchPublicStoreUseCase = fetchPublicStoreUseCase,
        super(PublicStoreInitial()) {
    on<PublicStoreFetched>(_onPublicStoreFetched);
  }

  FutureOr<void> _onPublicStoreFetched(
      PublicStoreFetched event, Emitter<PublicStoreState> emit) async {
    emit(PublicStoreLoading());
    try {
      final response = await _fetchPublicStoreUseCase.call();
      response.fold(
        (l) => emit(PublicStoreFailure(errorMessage: l.message)),
        (r) => emit(PublicStoreSuccess(storeEntities: r)),
      );
    } catch (e, s) {
      emit(PublicStoreFailure(errorMessage: 'Unexpected error occurred'));

      Log.error(
          'Fetch Store Exception Occurred Error: $e \n  \n StackTrace: $s');
    }
  }
}
