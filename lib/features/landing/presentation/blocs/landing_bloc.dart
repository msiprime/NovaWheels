import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';

import 'landing_event.dart';
import 'landing_state.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  LandingBloc(super.initialState) {
    on<NetworkNotFound>(_onNetworkNotFound);
    on<SyncingFailed>(_onSyncingFailed);
    on<SyncEvent>(_onSyncEvent);
    on<CountDown>(_onCountDown);
  }

  FutureOr<void> _onNetworkNotFound(
      NetworkNotFound event, Emitter<LandingState> emit) {}

  FutureOr<void> _onSyncingFailed(
      SyncingFailed event, Emitter<LandingState> emit) {}

  FutureOr<void> _onSyncEvent(SyncEvent event, Emitter<LandingState> emit) {}

  Future<void> _onCountDown(CountDown event, Emitter<LandingState> emit) async {
    final token = await CacheService.instance.retrieveBearerToken();
    final isFirstTimer = await CacheService.instance.retrieveIfUserFirstTimer();
    await Future.delayed(const Duration(seconds: 3));
    emit(
      state.copyWith(
        landingStatus: LandingStatus.navigate,
        token: token,
        isFirstTimer: isFirstTimer,
      ),
    );
  }
}
