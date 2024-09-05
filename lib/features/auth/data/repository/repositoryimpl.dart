import 'package:blog/core/error/failure.dart';
import 'package:blog/core/error/server_exception.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> currentSession() async {
    try {
      final user = await authRemoteDataSource.currentSession();
      if (user == null) {
        return left(Failure('User is not Logged In'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    return _getUser(() async => await authRemoteDataSource.login(
          email: email,
          password: password,
        ));
  }

  @override
  Future<Either<Failure, UserEntity>> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    return _getUser(() async => await authRemoteDataSource.signUp(
          name: name,
          email: email,
          password: password,
        ));
  }

  Future<Either<Failure, UserEntity>> _getUser(
      Future<UserEntity> Function() fn) async {
    try {
      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
