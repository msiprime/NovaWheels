import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/store/domain/entities/store_entity.dart';
import 'package:nova_wheels/features/store/domain/use_cases/fetch_store_by_id_usecase.dart';

part 'store_by_id_state.dart';

class StoreByIdCubit extends Cubit<StoreByIdState> {
  StoreByIdCubit({
    required FetchStoreByIdUseCase storeByIdUsecase,
  })  : _storeByIdUsecase = storeByIdUsecase,
        super(StoreByIdInitial());
  final FetchStoreByIdUseCase _storeByIdUsecase;

  void fetchStoreById(String id) async {
    emit(StoreByIdLoading());
    try {
      final store = await _storeByIdUsecase.call(storeId: id);
      store.fold(
        (failure) => emit(StoreByIdError(message: failure.message)),
        (store) => emit(StoreByIdLoaded(store: store.first)),
      );
    } catch (e) {
      emit(StoreByIdError(message: e.toString()));
    }
  }
}
