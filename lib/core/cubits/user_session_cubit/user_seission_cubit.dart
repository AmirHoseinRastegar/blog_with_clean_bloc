import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../entities/user_entity.dart';

part 'user_seission_state.dart';

class UserSeissionCubit extends Cubit<UserSeissionState> {
  UserSeissionCubit() : super(UserSeissionInitial());

  void updateUser(UserEntity? user) {
    if(user == null) {
      emit(UserSeissionInitial());
    } else {
      emit(UserIsloggedIn(user: user));
    }
  }


}
