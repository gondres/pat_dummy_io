import 'package:dio/dio.dart';
import 'package:pat_example_project/data/services/app_services.dart';
import 'package:pat_example_project/utils/dio_interceptor.dart';
import 'package:get_it/get_it.dart';

class RegisterService {
  final Dio dio;
  RegisterService(this.dio);
  final get = GetIt.I;

  registerAppServices(String url) async {
    dio.interceptors.clear();
    dio.options.receiveTimeout = Duration(milliseconds: 35000);
    dio.options.connectTimeout = Duration(milliseconds: 30000);
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, requestHeader: true, error: true));
    dio.interceptors.add(DioInterceptor());

    if (!get.isRegistered<AppServices>()) {
      get.registerFactory(() => AppServices(dio, baseUrl: url));
    } else {
      get.unregister<AppServices>();
      get.registerFactory(() => AppServices(dio, baseUrl: url));
    }
  }
}
