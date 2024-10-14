import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_store_state.dart';

class DeleteStoreCubit extends Cubit<DeleteStoreState> {
  DeleteStoreCubit() : super(DeleteStoreInitial());
}
