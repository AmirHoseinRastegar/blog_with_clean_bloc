import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubits/user_session_cubit/user_seission_cubit.dart';
import '../../../../core/entities/user_entity.dart';
import '../../../../core/use_case/use_case_inteface.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/sign_up_usecase.dart';
import '../../domain/use_cases/user_session.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUserCase;
  final LoginUseCase loginUseCase;
  final UserSessionUseCase userSessionUseCase;
  final UserSeissionCubit userSessionCubit;

  AuthBloc({required this.userSessionCubit,
    required this.userSessionUseCase,
    required this.loginUseCase,
    required this.signUpUserCase})
      : super(AuthInitial()) {
    on<AuthEvent> ((_,emit)=>
        emit(AuthLoading()));
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLogin);
    on<IsUserLoggedIn>(_onIsUserLoggedIn);
  }

  Future<void> _onIsUserLoggedIn(IsUserLoggedIn event,
      Emitter<AuthState> emit) async {
    final res = await userSessionUseCase.call(NoParams());
    res.fold(
          (l) => emit(AuthError(l.message)),
          (r) {
        print(r.name);
        _emitAuthSuccess(r, emit);
      },
    );
  }

  void _onSignUp(SignUpEvent event,
      Emitter<AuthState> emit,) async {
    final response = await signUpUserCase.call(SignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    response.fold((l) {
      emit(
        AuthError(l.message),
      );
    }, (r) => _emitAuthSuccess(r, emit));
  }

  void _onLogin(LoginEvent event,
      Emitter<AuthState> emit,) async {
    final res = await loginUseCase
        .call(LoginParams(email: event.email, password: event.password));
    res.fold(
            (l) =>
            emit(
              AuthError(l.message),
            ),
            (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    userSessionCubit.updateUser(user);
    emit(AuthSuccess(userId: user));
  }
}
