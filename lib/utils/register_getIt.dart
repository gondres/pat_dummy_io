import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pat_example_project/database/database_service.dart';

class RegisterGetIt {
  final getIt = GetIt.instance;

  void InitDI() {
    final dio = Dio();
    getIt.registerSingleton(DatabaseService());
    getIt.registerSingleton<Dio>(dio);
  }
}
