import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/delete_store_usecase.dart';

part 'update_store_event.dart';
part 'update_store_state.dart';

class UpdateStoreBloc extends Bloc<UpdateStoreEvent, UpdateStoreState> {
  final DeleteStoreUseCase _deleteStoreUseCase;

  UpdateStoreBloc({required DeleteStoreUseCase deleteStoreUseCase})
      : _deleteStoreUseCase = deleteStoreUseCase,
        super(UpdateStoreInitial()) {
    on<DeleteStorePressed>(_onDeleteStoreStarted);
  }

  FutureOr<void> _onDeleteStoreStarted(
    DeleteStorePressed event,
    Emitter<UpdateStoreState> emit,
  ) async {
    emit(DeleteStoreLoading());
    try {
      final response = await _deleteStoreUseCase.call(storeId: event.storeId);
      response.fold(
        (l) => emit(DeleteStoreError(errorMessage: l.message)),
        (r) => emit(DeleteStoreSuccess()),
      );
    } catch (e) {
      emit(DeleteStoreError(errorMessage: e.toString()));
    }
  }
}
