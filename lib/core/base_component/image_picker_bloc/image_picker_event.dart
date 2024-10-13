part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}

final class PickImageEvent extends ImagePickerEvent {
  // final ImageType imageType;

  // PickImageEvent({
  //   required this.imageType,
  // });
}

final class RemoveImageEvent extends ImagePickerEvent {}
