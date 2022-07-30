import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:topics/src/app/custom_exceptions/unsuccessful_request.dart';
import 'package:topics/src/app/managers/managers_lib.dart';
import 'package:topics/src/app/urls.dart';
import 'package:topics/src/core/core_lib.dart';

class HttpManagerImpl implements HttpManager {
  final HttpService _httpService;

  HttpManagerImpl(this._httpService);

  bool _initalized = false;

  @override
  Future<void> init() async {
    try {
      if (_initalized) return;
      // add default headers and default BaseOptions
      _httpService.init(baseUrl: Urls.baseURl, receiveTimeout: 120000);

      // insert default data needed to api like language,content-type, operating-system
      _httpService.insertInterceptor(0, _getDefaultInterceptor());
      if (!kReleaseMode) {
        _httpService.addInterceptor(PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90));
      }
      // _httpService.addInterceptor(_getLoggerInterceptor());
      //register interceptor to add accesstoken in header
      _initalized = true;
    } catch (ex) {
      if (kDebugMode) {
        print('HttpManagerImpl._init():${ex.toString()}');
      }
    }
  }

  @override
  HttpService get httpService => _httpService;

  InterceptorsWrapper _getDefaultInterceptor() => InterceptorsWrapper(onResponse: (
        Response response,
        ResponseInterceptorHandler handler,
      ) {
        if (response.statusCode != null && response.statusCode! < 200 || response.statusCode! >= 300) {
          throw UnsuccessfulRequest();
        }
        return handler.next(response); //continue
      }, onError: (error, handler) async {
        // Assume 401 stands for token expired
        if (error.response?.statusCode == 401) {
          //todo handle token expire
          return handler.resolve(await httpService.retry(error.requestOptions));
        }
        return handler.next(error);
      });
}
