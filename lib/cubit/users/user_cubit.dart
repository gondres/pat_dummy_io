import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/data/model/responses/detail_user_post_response.dart';
import 'package:pat_example_project/data/model/responses/detail_user_response.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/data/model/responses/list_user_response.dart';
import 'package:pat_example_project/data/repositories/app_repositories.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final AppRepositories repositories = AppRepositories();

  void getListUser(int page) async {
    emit(UserLoading());
    await repositories.getListUser(page).then((value) {
      if (value.isSuccess && value.dataResponse is ListUserResponse) {
        final res = value.dataResponse as ListUserResponse;
        emit(UserSuccess(res));
      } else {
        emit(UserFailure(message: value.dataResponse));
      }
    });
  }

  void getDetailUser(String id) async {
    emit(UserLoading());
    await repositories.getDetailUser(id).then((value) {
      if (value.isSuccess && value.dataResponse is DetailUserResponse) {
        final res = value.dataResponse as DetailUserResponse;
        emit(UserDetailSuccess(res));
      } else {
        emit(UserFailure(message: value.dataResponse));
      }
    });
  }

  void getUserFeeds(String id, int page) async {
    emit(UserLoading());
    await repositories.getUserFeed(id, page).then((value) {
      if (value.isSuccess && value.dataResponse is ListPostUserResponse) {
        final res = value.dataResponse as ListPostUserResponse;
        emit(UserFeedSuccess(res));
      } else {
        emit(UserFailure(message: value.dataResponse));
      }
    });
  }
}
