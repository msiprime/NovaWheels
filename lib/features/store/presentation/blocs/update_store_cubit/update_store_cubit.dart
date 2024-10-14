import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_store_state.dart';

class UpdateStoreCubit extends Cubit<UpdateStoreState> {
  UpdateStoreCubit() : super(UpdateStoreInitial());
}
