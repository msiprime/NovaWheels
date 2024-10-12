part of 'image_picker_cubit.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class ImagePickerLoading extends ImagePickerState {}

final class ImagePickerLoaded extends ImagePickerState {
  final File imageFile;

  ImagePickerLoaded(this.imageFile);
}

final class UploadingImageToSupabase extends ImagePickerState {}

final class RemovingImageFromSupabase extends ImagePickerState {}

final class ImageRemovedFromSupabase extends ImagePickerState {}

final class ImageUploadedToSupabase extends ImagePickerState {
  final String imageUrl;

  ImageUploadedToSupabase(this.imageUrl);
}

final class ImagePickerError extends ImagePickerState {
  final String message;

  ImagePickerError(this.message);
}
