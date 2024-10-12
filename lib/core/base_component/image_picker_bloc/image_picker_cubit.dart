import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerInitial());

  Future<void> pickImage() async {
    emit(ImagePickerLoading());
    try {
      final file = await ImagePicker()
          .pickImage(imageQuality: 10, source: ImageSource.gallery);
      if (file == null) return;

      emit(UploadingImageToSupabase());
      String imageUrl = await CoreDataSource.uploadStoreProfileImageToSupabase(
        File(file.path), // or 'cover' depending on your context
      );
      if (imageUrl.isNotEmpty) {
        emit(ImageUploadedToSupabase(imageUrl));
      }
    } catch (e) {
      emit(ImagePickerError('Error picking image'));
    }
  }

  Future<void> removeImage() async {
    emit(RemovingImageFromSupabase());
    await CoreDataSource.deleteImageFromSupabase();
    emit(ImageRemovedFromSupabase());
    emit(ImagePickerInitial());
  }
}
