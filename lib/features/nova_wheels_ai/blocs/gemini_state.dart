part of "gemini_bloc.dart";

@immutable
sealed class GeminiState {
  const GeminiState();
}

class Initial extends GeminiState {}

class Loading extends GeminiState {}

class Success extends GeminiState {
  final Candidates candidates;

  const Success(this.candidates);
}

class Failure extends GeminiState {
  final String message;

  const Failure(this.message);
}
