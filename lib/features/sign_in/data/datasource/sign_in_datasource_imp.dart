import 'package:google_sign_in/google_sign_in.dart';
import 'package:nova_wheels/config/supabase/secret/app_secrets.dart';
import 'package:nova_wheels/core/base_component/failure/exceptions.dart';
import 'package:nova_wheels/features/sign_in/data/datasource/sign_in_datasource.dart';
import 'package:nova_wheels/features/sign_in/data/model/sign_in_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInDataSourceImp implements SignInDataSource {
  final SupabaseClient supabaseClient;

  const SignInDataSourceImp({
    required this.supabaseClient,
  });

  @override
  Session? get currentSessionKey => supabaseClient.auth.currentSession;

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final accessToken = response.session?.accessToken;

      if (accessToken == null) {
        throw const ServerException('User token is null');
      }
      return accessToken;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentSessionKey != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select('*')
            .eq('id', currentSessionKey!.user.id);
        return UserModel.fromMap(userData.first);
      }
      return null;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final result =
          await supabaseClient.auth.signOut(scope: SignOutScope.global);
      // currentSessionKey = null;
      return result;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  Future<void> forgetPassword() async {
    try {
      final result = await supabaseClient.auth.resetPasswordForEmail(
        'msisakib958@gmail.com',
      );
      return result;
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<AuthResponse> googleSignIn() async {
    final webClientId = AppSecrets.webClientId;
    final iosClientId = AppSecrets.iosClientId;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
