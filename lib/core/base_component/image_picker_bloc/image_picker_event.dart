part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}

final class PickImageEvent extends ImagePickerEvent {
  final String fileName;

  PickImageEvent({
    required this.fileName,
  });
}

final class MultiplePickImageEvent extends ImagePickerEvent {
  final String fileName;

  MultiplePickImageEvent({
    required this.fileName,
  });
}

final class RemoveImageEvent extends ImagePickerEvent {}

final class RemoveMultipleImagesEvent extends ImagePickerEvent {}
