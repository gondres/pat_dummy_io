import 'package:dio/dio.dart';
import 'package:pat_example_project/base/base_url.dart' as baseParam;

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['app-id'] = baseParam.app_id;
    super.onRequest(options, handler);
  }
}
