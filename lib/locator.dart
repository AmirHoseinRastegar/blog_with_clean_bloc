import 'package:blog/core/connection/internet_connection.dart';
import 'package:blog/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/repository/repositoryimpl.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';
import 'package:blog/features/auth/domain/use_cases/login_usecase.dart';
import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/blog/data/data_sources/local/blog_local_data_source.dart';
import 'package:blog/features/blog/domain/use_cases/get_all_blogs_usecase.dart';
import 'package:blog/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/constants.dart';
import 'core/cubits/user_session_cubit/user_seission_cubit.dart';
import 'features/auth/domain/use_cases/sign_up_usecase.dart';
import 'features/auth/domain/use_cases/user_session.dart';
import 'features/blog/data/data_sources/blog_remote_data_source.dart';
import 'features/blog/data/repository/blog_repository_impl.dart';
import 'features/blog/domain/repository/blog_repository.dart';
import 'features/blog/domain/use_cases/upload_blog_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: Constants.supaBaseUrl, anonKey: Constants.supaBaseAnonKey);
  locator.registerLazySingleton(() => supabase.client);

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  ///core
  locator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  locator.registerLazySingleton(() => UserSeissionCubit());
  locator.registerFactory(() => InternetConnection());
  locator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      locator(),
    ),
  );
}

void _initBlog() {
  locator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteDataSource: locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => UploadBlogUseCase(
      locator(),
    ),
  );
  locator.registerFactory(
    () => GetALlBlogsUseCase(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => BlogBloc(
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<LocalBlogDataSource>(
    () => LocalBlogDataSourceImpl(box: locator()),
  );
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
        authRemoteDataSource: locator(), locator(), locator()),
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
