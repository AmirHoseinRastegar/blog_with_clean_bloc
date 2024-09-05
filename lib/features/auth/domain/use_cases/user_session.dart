import 'package:blog/core/error/failure.dart';
import 'package:blog/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/use_case/use_case_inteface.dart';

class UserSessionUseCase implements UseCaseInterface<UserEntity,NoParams > {
  final AuthRepository authRepository;

  UserSessionUseCase({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async{

  final user=  await authRepository.currentSession();
  return user;
  }
}