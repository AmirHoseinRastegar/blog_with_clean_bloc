import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signup({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserEntity>> currentSession();
}
