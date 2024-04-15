import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/data/repositories/app_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  final AppRepositories repositories = AppRepositories();

  void getListPost(int page) async {
    emit(PostLoading());
    await repositories.getListPost(page).then((value) {
      if (value.isSuccess && value.dataResponse is ListPostUserResponse) {
        final res = value.dataResponse as ListPostUserResponse;
        emit(PostSuccess(res));
      } else {
        emit(PostFailure(message: value.dataResponse));
      }
    });
  }

  void getTagListPost(String title, int page) async {
    emit(PostLoading());
    await repositories.getListTag(title, page).then((value) {
      if (value.isSuccess && value.dataResponse is ListPostUserResponse) {
        final res = value.dataResponse as ListPostUserResponse;
        emit(PostSuccess(res));
      } else {
        emit(PostFailure(message: value.dataResponse));
      }
    });
  }

  void getListUser(int page) async {
    emit(PostLoading());
    await repositories.getListUser(page).then((value) {
      if (value.isSuccess && value.dataResponse is ListPostUserResponse) {
        final res = value.dataResponse as ListPostUserResponse;
        emit(PostSuccess(res));
      } else {
        emit(PostFailure(message: value.dataResponse));
      }
    });
  }
}
