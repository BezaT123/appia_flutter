import 'package:equatable/equatable.dart';
import 'package:appia/models/models.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoadSuccess extends UserState {
  final User user;
  UserLoadSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class UserLoadFailure extends UserState {}

class UsersLoadSuccess extends UserState {
  final List<User> users;

  UsersLoadSuccess([this.users = const []]);

  @override
  List<Object> get props => [users];
}
