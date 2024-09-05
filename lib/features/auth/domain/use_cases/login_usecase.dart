import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/use_case/use_case_inteface.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCaseInterface<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {

  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
