import 'dart:io';

import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum ImageType {
  storeProfile(folderPath: 'profile_pictures', bucketName: 'store-images'),
  storeCover(folderPath: 'cover_pictures', bucketName: 'store-images'),
  userAvatar(folderPath: 'profile_picture', bucketName: 'avatars');

  final String folderPath;
  final String bucketName;

  const ImageType({
    required this.folderPath,
    required this.bucketName,
  });
}

abstract class CoreDataSource {
  static Future<String> uploadImageToSupabase({
    required File imageFile,
    required ImageType imageType,
    required String filePath,
  }) async {
    final SupabaseClient supabase = Supabase.instance.client;

    try {
      final response = await supabase.storage
          .from(imageType.bucketName)
          .upload(filePath, imageFile, fileOptions: FileOptions(upsert: true));
      Log.info(response);

      if (response.isEmpty) {
        throw Exception('Failed to upload image');
      }

      final imageUrl =
          supabase.storage.from(imageType.bucketName).getPublicUrl(filePath);
      return imageUrl;
    } catch (e) {
      return '';
    }
  }

  static Future<void> deleteImageFromSupabase({
    required String filePath,
    required ImageType imageType,
  }) async {
    final SupabaseClient supabase = Supabase.instance.client;

    try {
      final response =
          await supabase.storage.from(imageType.bucketName).remove([filePath]);

      if (response.isEmpty) {
        throw Exception('Error deleting image exception');
      }
    } catch (e) {
      Log.error('Error during image deletion: $e');
    }
  }
}
