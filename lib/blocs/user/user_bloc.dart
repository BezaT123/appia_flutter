import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'blocs.dart';
import 'package:meta/meta.dart';

import 'package:appia/blocs/user/user_event.dart';
import 'package:appia/blocs/user/user_state.dart';
import 'package:appia/models/user.dart';

import 'package:appia/repository/repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserLoading());

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SearchUserRequested) {
      yield* _mapAccountSearchUserRequested(event);
    } else {
      yield UserLoadFailure();
    }
  }

  Stream<UserState> _mapAccountSearchUserRequested(
      SearchUserRequested event) async* {
    yield UserLoading();
    try {
      final user = await userRepository.searchUser(event.username);
      yield UserLoadSuccess(user: user);
    } catch (_) {
      yield UserLoadFailure();
    }
  }
}
