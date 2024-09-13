import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quick_start/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:quick_start/features/sign_up/data/models/sign_up_model.dart';
import 'package:quick_start/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:quick_start/features/sign_up/domain/repositories/sign_up_repositories.dart';

class SignUpRepositoryImp implements SignUpRepository {
  const SignUpRepositoryImp({required this.signUpDataSource});

  final SignUpDataSource signUpDataSource;

  @override
  Future<Either<String, SignUpEntity>> signUp({
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final Response response =
          await signUpDataSource.signUp(requestBody: requestBody);

      SignUpEntity entity = SignUpModel.fromJson(response.data);

      return Right(entity);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, SignUpEntity>> verifyOTP(
      {required Map<String, dynamic> requestBody}) async {
    try {
      final Response response =
          await signUpDataSource.verifyOTP(requestBody: requestBody);

      SignUpEntity entity = SignUpModel.fromJson(response.data);

      return Right(entity);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
