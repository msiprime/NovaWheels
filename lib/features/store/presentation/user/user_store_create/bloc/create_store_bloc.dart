import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/params/store_creation_params.dart';
import 'package:nova_wheels/features/store/domain/use_cases/create_store_usecase.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

part 'create_store_event.dart';
part 'create_store_state.dart';

class CreateStoreBloc extends Bloc<CreateStoreEvent, CreateStoreState> {
  final CreateStoreUseCase _createStoreUseCase;

  CreateStoreBloc({
    required CreateStoreUseCase createStoreUseCase,
  })  : _createStoreUseCase = createStoreUseCase,
        super(CreateStoreInitial()) {
    on<CreateStoreTapped>(
      _onCreateStoreTapped,
      transformer: droppable(),
    );
  }

  FutureOr<void> _onCreateStoreTapped(
      CreateStoreTapped event, Emitter<CreateStoreState> emit) async {
    emit(const CreateStoreLoading());
    try {
      final response = await _createStoreUseCase(
          storeCreationParams: event.storeCreationParams);

      response.fold(
        (l) => emit(CreateStoreFailure(errorMessage: l.message)),
        (r) => emit(CreateStoreSuccess(storeEntity: r)),
      );
    } catch (e, s) {
      Log.error('Error exception on create store: error: $e stack: $s');
      emit(
        CreateStoreFailure(errorMessage: 'Unexpected error occurred'),
      );
    }
  }
}
