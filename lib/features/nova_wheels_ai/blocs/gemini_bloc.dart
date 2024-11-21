import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(Initial()) {
    on<GeminiEvent>((event, emit) {
      // TODO: implement event handler
    });

    // on<GeminiTextFieldChanged>(_onGeminiTextFieldChanged);
    on<GeminiTextFieldSubmitted>(_onGeminiTextFieldSubmitted);
  }

  FutureOr<void> _onGeminiTextFieldSubmitted(
      GeminiTextFieldSubmitted event, Emitter<GeminiState> emit) async {
    emit(Loading());
    final gemini = Gemini.instance;
    try {
      final candidatesStream = gemini.streamGenerateContent(event.prompt);

      await emit.forEach(
        candidatesStream,
        onData: (candidates) => Success(candidates),
        onError: (error, stackTrace) => Failure(error.toString()),
      );
    } catch (e) {
      emit(Failure(e.toString()));
    }
  }
}
