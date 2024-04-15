part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserSuccess extends UserState {
  final ListUserResponse response;

  const UserSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UserDetailSuccess extends UserState {
  final DetailUserResponse response;

  const UserDetailSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UserFeedSuccess extends UserState {
  final ListPostUserResponse response;

  const UserFeedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
