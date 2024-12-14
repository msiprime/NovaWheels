import 'package:nova_wheels/core/base_component/failure/exceptions.dart';
import 'package:nova_wheels/features/profile/data/datasources/profile_datasource.dart';
import 'package:nova_wheels/features/profile/data/models/profile_model.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final SupabaseClient supabaseClient;

  ProfileDataSourceImpl({
    required this.supabaseClient,
  });

  @override
  Future<ProfileModel> fetchProfile() async {
    final currentUser = supabaseClient.auth.currentUser;

    if (currentUser == null) {
      throw Exception('User is not authenticated');
    }

    final fcmToken = await CacheService.instance.retrieveFcmToken();
    try {
      await supabaseClient
          .from('profiles')
          .update({'fcm_token': fcmToken})
          .eq('id', currentUser.id)
          .single();
    } catch (e) {
      Log.error('Failed to store FCM token: $e');
    }

    try {
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUser.id)
          .single();

      if (response.isEmpty) {
        throw Exception('Failed to fetch profile: $response');
      }

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String fullName,
    required String userName,
    required String email,
    required String mobileNumber,
    required String website,
    required String avatarUrl,
  }) async {
    try {
      final currentUser = supabaseClient.auth.currentUser;

      if (currentUser == null) {
        throw Exception('User is not authenticated');
      }

      final List<Map<String, dynamic>> response = await supabaseClient
          .from('profiles')
          .update({
            'full_name': fullName,
            'username': userName,
            'email': email,
            'phone_number': mobileNumber,
            'website': website,
            'avatar_url': avatarUrl,
          })
          .eq('id', currentUser.id)
          .select();

      if (response.isEmpty) {
        throw Exception('Failed to update profile: $response');
      }
      return ProfileModel.fromJson(response.first);
    } on PostgrestException catch (e) {
      throw Exception(
          'Failed to update profile on Postgrest oh god! : ${e.toString()}');
    } on ServerException catch (e) {
      throw Exception(
          'Failed to update profile on Server oh no! : ${e.toString()}');
    } catch (e) {
      throw Exception('Failed to update profile oh shit: ${e.toString()}');
    }
  }

  @override
  Future<ProfileModel> fetchProfileById({
    required String profileId,
  }) async {
    try {
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', profileId)
          .single();

      if (response.isEmpty) {
        throw Exception('Failed to fetch profile: $response');
      }

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }
}
