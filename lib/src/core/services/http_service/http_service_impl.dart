import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'http_service.dart';

class HttpServiceImpl extends HttpService {
  late Dio _dioInstance;

  @override
  void init({
    int connectTimeout = HttpService.connectTimeout,
    int receiveTimeout = HttpService.receiveTimeout,
    int sendTimeout = HttpService.sendTimeout,
    String baseUrl = '',
    ResponseType responseType = ResponseType.json,
    ContentType contentType = ContentType.applicationJson,
  }) {
    BaseOptions options = BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        responseType: responseType,
        contentType: contentType.toString());

    _dioInstance = Dio(options);
  }

  @override
  void addInterceptor(Interceptor element) {
    _dioInstance.interceptors.add(element);
  }

  @override
  void insertInterceptor(int index, Interceptor element) {
    _dioInstance.interceptors.insert(index, element);
  }

  /// path --> backSlash with path of API
  /// headers --> headers of request to be included/ override default headers
  /// contentType --> application/x-www-form-urlencoded ot  application/json or empty or others ....
  @override
  Future<CustomResponse> get(String path, RequestData requestData) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.get(path);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> getUri(Uri uri, RequestData requestData) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.getUri(uri);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> post(String path, RequestData requestData, dynamic data) async {
    //  _prepareRequest(requestData);
    var response = await _dioInstance.post(path, data: json.encode(data));
    return CustomResponse.fromDIOReponse(response);
  }

  @override
  Future<CustomResponse> postUri(Uri uri, RequestData requestData, dynamic data) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.postUri(uri, data: data);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> put(String path, RequestData requestData, dynamic data) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.put(path, data: data);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> putUri(Uri uri, RequestData requestData, dynamic data) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.putUri(uri, data: data);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> delete(String path, RequestData requestData, dynamic data) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.delete(path, data: data);
    return CustomResponse.fromDIOReponse(result);
  }

  @override
  Future<CustomResponse> deleteUri(Uri uri, RequestData requestData, dynamic data) async {
    _prepareRequest(requestData);

    Response result = await _dioInstance.deleteUri(uri, data: data);
    return CustomResponse.fromDIOReponse(result);
  }


  // add default headers and content type
  void _prepareRequest(RequestData requestData) {
    if (requestData.headers != null && requestData.headers?.isNotEmpty == true) {
      _dioInstance.options.headers.addAll(requestData.headers!);
    }
    if (requestData.contentType != null) {
      _dioInstance.options.contentType = requestData.contentType.toString();
    }
  }


  @override
  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return _dioInstance.request<dynamic>(requestOptions.path,
        data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }
}

class ContentType extends Equatable {
  final String _value;

  const ContentType._(this._value);

  static const ContentType applicationJson = ContentType._("application/json");
  static const ContentType formUrlEncoded = ContentType._("application/x-www-form-urlencoded");
  static const ContentType emptyEncoding = ContentType._("");

  @override
  String toString() {
    return _value;
  }

  @override
  List<Object> get props => [_value];
}
