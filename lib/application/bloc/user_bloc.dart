// ignore_for_file: library_private_types_in_public_api

import 'package:bloc/bloc.dart';
import 'package:bloc_freezed/domain/model/userModel.dart';
import 'package:bloc_freezed/domain/service/userService.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const _Initial()) {
    on<_GetUsers>(getUser);
    add(const _GetUsers());

    /// on getuserni tinglab turadi
    ///
    /// add faqat ishga tushirib beradi agar tugma bosilsa ishlaydi yoki initial da
  }

  final UserService _userService = UserService();

  Future<void> getUser(_GetUsers event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    Either<String, List<UserModel>> response = await _userService.getUser();
    response.fold((error) => emit(UserState.error(error)),
        (data) => emit(UserState.complete(data)));
  }
}
