import 'package:flutter_user_cubit/user_list/model/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  const factory UserListState.initial() = UserListInitial;
  const factory UserListState.loading() = UserListLoading;
  const factory UserListState.success(List<User> users) = UserListSuccess;
  const factory UserListState.error(String errorMessage) = UserListError;

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {
  const UserListInitial();
}

class UserListLoading extends UserListState {
  const UserListLoading();
}

class UserListSuccess extends UserListState {
  final List<User> users;

  const UserListSuccess(this.users);
}

class UserListError extends UserListState {
  final String errorMessage;

  const UserListError(this.errorMessage);
}
