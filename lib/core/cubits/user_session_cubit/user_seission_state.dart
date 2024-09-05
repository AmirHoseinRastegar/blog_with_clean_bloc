part of 'user_seission_cubit.dart';

@immutable
sealed class UserSeissionState {}

final class UserSeissionInitial extends UserSeissionState {}
final class UserIsloggedIn extends UserSeissionState {
  final UserEntity user;

  UserIsloggedIn({required this.user});

}
