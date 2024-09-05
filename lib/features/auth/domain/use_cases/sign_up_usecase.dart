import 'package:blog/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/user_entity.dart';
import '../../../../core/use_case/use_case_inteface.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase implements UseCaseInterface<UserEntity, SignUpParams> {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    return await authRepository.signup(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams(
      {required this.name, required this.email, required this.password});
}
