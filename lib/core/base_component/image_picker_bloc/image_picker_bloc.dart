import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_wheels/core/datasource/core_datasource.dart';
import 'package:shared/shared.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImageType imageType;

  ImagePickerBloc({
    required this.imageType,
  }) : super(ImagePickerInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<MultiplePickImageEvent>(_onMultiplePickImage);
    on<RemoveImageEvent>(_onRemoveImage);
    on<RemoveMultipleImagesEvent>(_onRemoveMultipleImages);
  }

  String? globalFilePath;
  List<String?>? globalFilePaths;

  FutureOr<void> _onPickImage(PickImageEvent event, emit) async {
    emit(ImagePickerLoading());
    try {
      final file = await ImagePicker()
          .pickImage(imageQuality: 10, source: ImageSource.gallery);
      if (file == null) return;

      String filePath = '${imageType.folderPath}/${event.fileName}.jpg';
      globalFilePath = filePath;

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
    String filePath = globalFilePath ?? '';

    emit(RemovingImageFromSupabase());
    await CoreDataSource.deleteImageFromSupabase(
      filePath: filePath,
      imageType: imageType,
    );
    emit(ImageRemovedFromSupabase());
    emit(ImagePickerInitial());
  }

  FutureOr<void> _onMultiplePickImage(
      MultiplePickImageEvent event, Emitter<ImagePickerState> emit) async {
    emit(ImagePickerLoading());
    try {
      final files = await ImagePicker().pickMultiImage();

      List<String> imageUrls = [];
      for (final file in files) {
        String filePath = '${imageType.folderPath}/${event.fileName}.jpg';
        globalFilePaths?.add(filePath);
        emit(UploadingImageToSupabase());
        String imageUrl = await CoreDataSource.uploadImageToSupabase(
          imageFile: File(file.path),
          imageType: imageType,
          filePath: filePath,
        );
        if (imageUrl.isNotEmpty) {
          imageUrls.add(imageUrl);
        }
        logE(imageUrls);
      }
      emit(MultipleImagesUploadedToSupabase(imageUrls));
    } catch (e) {
      emit(ImagePickerError('Error picking image'));
    }
  }

  FutureOr<void> _onRemoveMultipleImages(
      RemoveMultipleImagesEvent event, Emitter<ImagePickerState> emit) async {
    List<String?> filePaths = globalFilePaths ?? [];

    emit(RemovingImageFromSupabase());

    await CoreDataSource.deleteBatchImagesFromSupabase(
      filePaths: filePaths.map((e) => e ?? '').toList(),
      imageType: imageType,
    );
    emit(MultipleImagesRemovedFromSupabase());
    emit(ImagePickerInitial());
  }
}
