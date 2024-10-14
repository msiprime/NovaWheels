import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/create_store_usecase.dart';

part 'create_store_state.dart';

class CreateStoreCubit extends Cubit<CreateStoreState> {
  final CreateStoreUseCase createStoreUseCase;

  CreateStoreCubit({
    required this.createStoreUseCase,
  }) : super(CreateStoreInitial());

  void createStore({
    required StoreCreationParams storeCreationParams,
  }) async {
    emit(const CreateStoreLoading());
    try {
      final response =
          await createStoreUseCase(storeCreationParams: storeCreationParams);

      response.fold(
        (l) => emit(CreateStoreFailure(errorMessage: l.message)),
        (r) => emit(CreateStoreSuccess(storeEntity: r)),
      );
    } catch (e) {
      emit(CreateStoreFailure(errorMessage: e.toString()));
    }
  }
}
