import 'package:dartz/dartz.dart';
import 'package:nova_wheels/core/base_component/failure/exceptions.dart';
import 'package:nova_wheels/core/base_component/failure/failures.dart';
import 'package:nova_wheels/features/sign_in/data/datasource/sign_in_datasource.dart';
import 'package:nova_wheels/features/sign_in/data/model/sign_in_model.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/shared/local_storage/cache_service.dart';
import 'package:nova_wheels/shared/utils/connection_checker/connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInRepoImp implements SignInRepository {
  final ConnectionChecker connectionChecker;
  final SignInDataSource signInRemoteDataSource;

  const SignInRepoImp({
    required this.signInRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, UserModel>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = signInRemoteDataSource.currentSessionKey;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            fullName: '',
          ),
        );
      }
      final user = await signInRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signIn({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final response = await signInRemoteDataSource.signIn(
        email: requestBody['email'],
        password: requestBody['password'],
      );

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signOut() async {
    try {
      await signInRemoteDataSource.signOut();
      CacheService.instance.clearAllToken();
      return right('Sign out successful');
    } on ServerException catch (e) {
      return left(
        Failure(e.message),
      );
    } on AuthException catch (e) {
      return left(
        Failure(e.message),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, String>> googleSignIn() async {
    try {
      final response = await signInRemoteDataSource.googleSignIn();

      final accessToken = response.session?.accessToken;

      if (accessToken == null) {
        throw const ServerException('User token is null');
      }

      return right(accessToken);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
