import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/features/vehicle/domain/entities/vehicle_entity.dart';

part 'post_vehicle_event.dart';
part 'post_vehicle_state.dart';

class PostVehicleBloc extends Bloc<PostVehicleEvent, PostVehicleState> {
  PostVehicleBloc() : super(AddVehicleInitial()) {
    on<PostVehicleEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
