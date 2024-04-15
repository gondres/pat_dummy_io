import 'package:get_it/get_it.dart';
import 'package:pat_example_project/data/model/responses/repository_response.dart';
import 'package:pat_example_project/data/services/app_services.dart';

class AppRepositories {
  Future<RepositoriesResponse> getListPost(int page) async {
    final services = GetIt.I.get<AppServices>();
    late RepositoriesResponse response;

    try {
      await services.listPost(page).then((value) {
        response = RepositoriesResponse(isSuccess: true, dataResponse: value);
      });
    } catch (e) {
      response = RepositoriesResponse(isSuccess: true, dataResponse: e);
    }

    return response;
  }

  Future<RepositoriesResponse> getListTag(String title, int page) async {
    final services = GetIt.I.get<AppServices>();
    late RepositoriesResponse response;

    try {
      await services.listTagPost(title, page).then((value) {
        response = RepositoriesResponse(isSuccess: true, dataResponse: value);
      });
    } catch (e) {
      response = RepositoriesResponse(isSuccess: true, dataResponse: e);
    }

    return response;
  }

  Future<RepositoriesResponse> getListUser(int page) async {
    final services = GetIt.I.get<AppServices>();
    late RepositoriesResponse response;

    try {
      await services.listUser(page).then((value) {
        response = RepositoriesResponse(isSuccess: true, dataResponse: value);
      });
    } catch (e) {
      response = RepositoriesResponse(isSuccess: true, dataResponse: e);
    }

    return response;
  }

  Future<RepositoriesResponse> getDetailUser(String id) async {
    final services = GetIt.I.get<AppServices>();
    late RepositoriesResponse response;

    try {
      await services.detailUser(id).then((value) {
        response = RepositoriesResponse(isSuccess: true, dataResponse: value);
      });
    } catch (e) {
      response = RepositoriesResponse(isSuccess: true, dataResponse: e);
    }

    return response;
  }

  Future<RepositoriesResponse> getUserFeed(String id, int page) async {
    final services = GetIt.I.get<AppServices>();
    late RepositoriesResponse response;

    try {
      await services.detailUserPost(id, page).then((value) {
        response = RepositoriesResponse(isSuccess: true, dataResponse: value);
      });
    } catch (e) {
      response = RepositoriesResponse(isSuccess: true, dataResponse: e);
    }

    return response;
  }
}
