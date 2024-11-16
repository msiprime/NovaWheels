import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_store_update_event.dart';
part 'user_store_update_state.dart';

class UserStoreUpdateBloc
    extends Bloc<UserStoreUpdateEvent, UserStoreUpdateState> {
  UserStoreUpdateBloc() : super(UserStoreUpdateInitial()) {
    on<UserStoreUpdateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
