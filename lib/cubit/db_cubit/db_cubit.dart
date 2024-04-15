import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pat_example_project/database/database_service.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
part 'db_state.dart';

class DBCubit extends Cubit<DBState> {
  DBCubit() : super(DBInitial());

  final _databaseService = DatabaseService();

  void insertLikes(Data data) async {
    final mapper = likesMapperFromResponse(data: data);
    emit(DBLoading());
    try {
      await _databaseService.insertLikes(mapper);
      emit(DBSuccess());
    } catch (e) {
      emit(DBFailure(message: e.toString()));
    }
  }

  void deleteLike(String id) async {
    try {
      await _databaseService.deleteLikes(id);
      final getList = await _databaseService.getLikesList();
      emit(DBListSuccess(model: getList));
    } catch (e) {
      emit(DBFailure(message: e.toString()));
    }
  }

  void getListLikes() async {
    try {
      final db = await _databaseService.getLikesList();
      emit(DBListSuccess(model: db));
    } catch (e) {
      emit(DBFailure(message: e.toString()));
    }
  }
}
