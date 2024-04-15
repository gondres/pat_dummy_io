part of 'db_cubit.dart';

abstract class DBState extends Equatable {
  const DBState();

  @override
  List<Object?> get props => [];
}

class DBInitial extends DBState {}

class DBSuccess extends DBState {}

class DBListSuccess extends DBState {
  final List<LikesModel> model;

  const DBListSuccess({required this.model});

  @override
  List<Object?> get props => [model];
}

class DBLoading extends DBState {}

class DBFailure extends DBState {
  final String message;

  const DBFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
