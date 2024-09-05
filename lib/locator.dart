import 'package:blog/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repository/repositoryimpl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/use_cases/login_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/constants.dart';
import 'core/cubits/user_session_cubit/user_seission_cubit.dart';
import 'features/auth/domain/use_cases/sign_up_usecase.dart';
import 'features/auth/domain/use_cases/user_session.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  _initAuth();

  final supabase = await Supabase.initialize(
      url: Constants.supaBaseUrl, anonKey: Constants.supaBaseAnonKey);
  locator.registerLazySingleton(() => supabase.client);

  ///core
  locator.registerLazySingleton(() => UserSeissionCubit());
}

void _initAuth() {
  ///register factory causes that the instance get created every time we use it
  ///but single tone is only created once
  locator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      locator(),
    ),
  );
  locator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: locator(),
    ),
  );
  locator.registerFactory(
    () => SignUpUseCase(
      authRepository: locator(),
    ),
  );
  locator.registerFactory(
    () => LoginUseCase(
      authRepository: locator(),
    ),
  );
  locator.registerFactory(
    () => UserSessionUseCase(
      authRepository: locator(),
    ),
  );

  ///bloc needs to be created only once and not every time we use it
  ///so we use lazy singleton
  locator.registerLazySingleton(
    () => AuthBloc(
      signUpUserCase: locator(),
      loginUseCase: locator(),
      userSessionUseCase: locator(),
      userSessionCubit: locator(),
    ),
  );
}
