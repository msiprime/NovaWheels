import 'dart:io';

import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CoreDataSource {
  static late final String globalFilePath;

  static Future<String> uploadStoreProfileImageToSupabase(
      File imageFile) async {
    final SupabaseClient supabase = Supabase.instance.client;

    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = 'profile_pictures/$fileName';
      globalFilePath = filePath;
      final response = await supabase.storage
          .from('store-images')
          .upload(filePath, imageFile, fileOptions: FileOptions(upsert: true));
      Log.info(response);

      if (response.isEmpty) {
        throw Exception('Failed to upload image');
      }

      final imageUrl =
          supabase.storage.from('store-images').getPublicUrl(filePath);
      return imageUrl;
    } catch (e) {
      return '';
    }
  }

  static Future<void> deleteImageFromSupabase() async {
    final SupabaseClient supabase = Supabase.instance.client;

    try {
      final response =
          await supabase.storage.from('store-images').remove([globalFilePath]);

      if (response.isEmpty) {
        throw Exception('Error deleting image exception');
      }
    } catch (e) {
      Log.error('Error during image deletion: $e');
    }
  }
}
