import 'dart:convert';

import 'package:dio/dio.dart';

import 'http_service_impl.dart';

abstract class HttpService {
  static const int connectTimeout = 40000, receiveTimeout = 40000, sendTimeout = 40000;

  /// update base API options defaults like [base_url, timeouts, headers, contentType ...]
  void init(
      {int connectTimeout = HttpService.connectTimeout,
      int receiveTimeout = HttpService.receiveTimeout,
      int sendTimeout = HttpService.sendTimeout,
      String baseUrl = '',
      ResponseType responseType = ResponseType.json,
      ContentType contentType = ContentType.applicationJson});

  ///region =========  API_ACTIONS
  Future<CustomResponse> get(String path, RequestData requestData);

  Future<CustomResponse> getUri(Uri uri, RequestData requestData);

  Future<CustomResponse> post(String path, RequestData requestData, dynamic data);

  Future<CustomResponse> postUri(Uri uri, RequestData requestData, dynamic data);

  Future<CustomResponse> put(String path, RequestData requestData, dynamic data);

  Future<CustomResponse> putUri(Uri uri, RequestData requestData, dynamic data);

  Future<CustomResponse> delete(String path, RequestData requestData, dynamic data);

  Future<CustomResponse> deleteUri(Uri uri, RequestData requestData, dynamic data);

  //endregion

  //region DIO custom functions
  void addInterceptor(Interceptor element);

  void insertInterceptor(int index, Interceptor element);

  retry(RequestOptions requestOptions);

//endregion

}

class RequestData {
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? requestParameters;
  final ContentType? contentType;

  RequestData({this.headers, this.contentType, this.requestParameters});
}

// same as dio response but to be used form our side in app in case we replaced DIO will add only new factory nethod
class CustomResponse {
  CustomResponse({
    this.data,
    Headers? headers,
    required this.requestOptions,
    this.isRedirect,
    this.statusCode,
    this.statusMessage,
    List<RedirectRecord>? redirects,
    this.extra,
  }) {
    this.extra = extra ?? {};
    this.redirects = redirects ?? [];
  }

  factory CustomResponse.fromDIOReponse(Response dioResponse) {
    return CustomResponse(
      data: dioResponse.data,
      headers: dioResponse.headers,
      requestOptions: dioResponse.requestOptions,
      isRedirect: dioResponse.isRedirect,
      statusCode: dioResponse.statusCode,
      statusMessage: dioResponse.statusMessage,
      redirects: dioResponse.redirects,
      extra: dioResponse.extra,
    );
  }

  /// Response body. may have been transformed, please refer to [ResponseType].
  dynamic data;

  /// The corresponding request info.
  late RequestOptions requestOptions;

  /// Http status code.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;

  /// Custom field that you can retrieve it later in `then`.
  Map<String, dynamic>? extra;

  /// Returns the series of redirects this connection has been through. The
  /// list will be empty if no redirects were followed. [redirects] will be
  /// updated both in the case of an automatic and a manual redirect.
  ///
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  late List<RedirectRecord> redirects;

  /// Whether this response is a redirect.
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  bool? isRedirect;

  /// Return the final real request uri (maybe redirect).
  ///
  /// ** Attention **: Whether this field is available depends on whether the
  /// implementation of the adapter supports it or not.
  Uri get realUri => (redirects.isNotEmpty) ? redirects.last.location : requestOptions.uri;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
