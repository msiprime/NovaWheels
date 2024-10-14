import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nova_wheels/config/supabase/secret/app_secrets.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_bloc.dart';
import 'package:nova_wheels/core/base_component/base/base_bloc/base_state.dart';
import 'package:nova_wheels/features/landing/presentation/blocs/landing_bloc.dart';
import 'package:nova_wheels/features/landing/presentation/blocs/landing_state.dart';
import 'package:nova_wheels/features/sign_in/data/datasource/sign_in_datasource.dart';
import 'package:nova_wheels/features/sign_in/data/datasource/sign_in_datasource_imp.dart';
import 'package:nova_wheels/features/sign_in/data/repository/sign_in_repo_imp.dart';
import 'package:nova_wheels/features/sign_in/domain/repositories/sign_in_repositories.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/google_sign_in_usecase.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/otp_verification_usecase.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/request_otp_usecase.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/reset_password_usecase.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:nova_wheels/features/sign_in/domain/use_cases/user_signout_usecase.dart';
import 'package:nova_wheels/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:nova_wheels/features/sign_up/data/data_sources/sign_up_data_source.dart';
import 'package:nova_wheels/features/sign_up/data/data_sources/sign_up_data_source_imp.dart';
import 'package:nova_wheels/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:nova_wheels/features/sign_up/domain/repositories/sign_up_repositories.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/otp_verification_usecase.dart';
import 'package:nova_wheels/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:nova_wheels/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource.dart';
import 'package:nova_wheels/features/store/data/data_sources/store_datasource_impl.dart';
import 'package:nova_wheels/features/store/data/repositories/store_repo_impl.dart';
import 'package:nova_wheels/features/store/domain/repositories/store_repo.dart';
import 'package:nova_wheels/features/store/domain/use_cases/create_store_usecase.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource.dart';
import 'package:nova_wheels/features/vehicle/data/datasources/vehicle_datasource_impl.dart';
import 'package:nova_wheels/features/vehicle/data/repositories/vehicle_repo_impl.dart';
import 'package:nova_wheels/features/vehicle/domain/repositories/vehicle_repo.dart';
import 'package:nova_wheels/features/vehicle/domain/use_cases/vehicle_usecase.dart';
import 'package:nova_wheels/features/vehicle/presentation/blocs/vehicle_bloc.dart';
import 'package:nova_wheels/shared/remote_datasource/network/rest_client.dart'
    show RestClient;
import 'package:nova_wheels/shared/utils/connection_checker/connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'bloc.dart';
part 'data_source.dart';
part 'repository.dart';
part 'use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  await _initBlocs();

  /// UseCase
  await _initUseCases();

  /// Repository
  await _initRepositories();

  /// Datasource
  await _initDataSources();

  /// Network
  final restClient = RestClient();
  sl.registerLazySingleton(
    () => restClient,
  );

  final supaBase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaAnonKey,
  );

  /// supabase
  sl.registerLazySingleton<SupabaseClient>(
    () => supaBase.client,
  );

  /// internet connection checker
  sl.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: sl.call()),
  );

  /// internet connection
  sl.registerFactory<InternetConnection>(() => InternetConnection());
}
