import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nova_wheels/features/sign_in/data/datasource/sign_in_datasource.dart';
import 'package:nova_wheels/features/sign_in/data/model/sign_in_model.dart';
import 'package:nova_wheels/features/sign_in/domain/entities/sign_in_entity.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/shared/utils/logger.dart';

class SignInRepoImp implements SignInRepository {
  const SignInRepoImp({required this.signInRemoteDataSource});

  final SignInDataSource signInRemoteDataSource;

  @override
  Future<Either<String, SignInEntity>> signIn({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final Response response =
          await signInRemoteDataSource.signIn(requestBody: requestBody);

      SignInEntity entity = SignInModel.fromJson(response.data['data']);

      return Right(entity);
    } catch (e, stackTrace) {
      Log.info(e.toString());
      Log.info(stackTrace.toString());
      return Left(e.toString());
    }
  }
}
