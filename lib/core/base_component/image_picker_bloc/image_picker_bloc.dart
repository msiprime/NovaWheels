import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImageType imageType;

  ImagePickerBloc({
    required this.imageType,
  }) : super(ImagePickerInitial()) {
    on<PickImageEvent>(_onPickImage);

    on<RemoveImageEvent>(_onRemoveImage);
  }

  String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

  FutureOr<void> _onPickImage(PickImageEvent event, emit) async {
    emit(ImagePickerLoading());
    try {
      final file = await ImagePicker()
          .pickImage(imageQuality: 10, source: ImageSource.gallery);
      if (file == null) return;

      String filePath = '${imageType.folderPath}/$fileName';

      emit(UploadingImageToSupabase());
      String imageUrl = await CoreDataSource.uploadImageToSupabase(
        imageFile: File(file.path),
        imageType: imageType,
        filePath: filePath,
      );
      if (imageUrl.isNotEmpty) {
        emit(ImageUploadedToSupabase(imageUrl));
      }
    } catch (e) {
      emit(ImagePickerError('Error picking image'));
    }
  }

  FutureOr<void> _onRemoveImage(RemoveImageEvent event, emit) async {
    String filePath = '${imageType.folderPath}/$fileName';

    emit(RemovingImageFromSupabase());
    await CoreDataSource.deleteImageFromSupabase(
      filePath: filePath,
      imageType: imageType,
    );
    emit(ImageRemovedFromSupabase());
    emit(ImagePickerInitial());
  }
}
