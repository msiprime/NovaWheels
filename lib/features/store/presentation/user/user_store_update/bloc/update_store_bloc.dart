import 'dart:async';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/delete_store_usecase.dart';
import 'package:nova_wheels/features/store/domain/use_cases/update_store_usecase.dart';

part 'update_store_event.dart';
part 'update_store_state.dart';

class UpdateStoreBloc extends Bloc<UpdateStoreEvent, UpdateStoreState> {
  final DeleteStoreUseCase _deleteStoreUseCase;
  final UpdateStoreUseCase _updateStoreUseCase;

  UpdateStoreBloc(
      {required DeleteStoreUseCase deleteStoreUseCase,
      required UpdateStoreUseCase updateStoreUseCase})
      : _deleteStoreUseCase = deleteStoreUseCase,
        _updateStoreUseCase = updateStoreUseCase,
        super(UpdateStoreInitial()) {
    on<DeleteStorePressed>(_onDeleteStoreStarted);
    on<UpdateStorePressed>(_onUpdateStoreStarted);
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

  FutureOr<void> _onUpdateStoreStarted(
      UpdateStorePressed event, Emitter<UpdateStoreState> emit) async {
    emit(UpdateStoreLoading());
    try {
      final response = await _updateStoreUseCase.call(event.storeEntity);
      response.fold(
        (l) => emit(UpdateStoreError(errorMessage: l.message)),
        (r) => emit(UpdateStoreSuccess(store: r)),
      );
    } catch (e) {
      emit(UpdateStoreError(errorMessage: e.toString()));
    }
  }
}
