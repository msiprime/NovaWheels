part of 'gemini_bloc.dart';

sealed class GeminiEvent extends Equatable {
  const GeminiEvent();
}

class GeminiTextFieldChanged extends GeminiEvent {
  final String text;

  const GeminiTextFieldChanged(this.text);

  @override
  List<Object> get props => [text];
}

class GeminiTextFieldSubmitted extends GeminiEvent {
  const GeminiTextFieldSubmitted(this.prompt);

  final String prompt;

  @override
  List<Object> get props => [prompt];
}
