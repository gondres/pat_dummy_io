part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostSuccess extends PostState {
  final ListPostUserResponse response;

  const PostSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PostLoading extends PostState {}

class PostFailure extends PostState {
  final String message;

  const PostFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
