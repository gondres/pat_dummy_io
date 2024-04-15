import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pat_example_project/data/model/responses/detail_user_response.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/data/model/responses/list_user_response.dart';
import 'package:retrofit/http.dart';
import 'package:pat_example_project/base/base_url.dart' as baseUrl;
import 'package:retrofit/retrofit.dart';

part 'app_services.g.dart';

@RestApi()
abstract class AppServices {
  factory AppServices(Dio dio, {String baseUrl}) = _AppServices;

  @GET('${baseUrl.post}?page={page}')
  Future<ListPostUserResponse> listPost(@Path('page') int page);

  @GET('tag/{title}/post?page={page}')
  Future<ListPostUserResponse> listTagPost(@Path('title') String title, @Path('page') int page);

  @GET('${baseUrl.users}?page={page}')
  Future<ListUserResponse> listUser(@Path('page') int page);

  @GET('${baseUrl.users}/{id}')
  Future<DetailUserResponse> detailUser(@Path('id') String id);

  @GET('${baseUrl.users}/{id}/${baseUrl.post}?page={page}')
  Future<ListPostUserResponse> detailUserPost(@Path('id') String id, @Path('page') int page);
}
