import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/enums/string_enums.dart';
import '../error/exceptions.dart';
import '../network/netwok_info.dart';
import 'api_consumer.dart';
// import 'api_keys.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;
  final NetworkInfo networkInfo;

  DioConsumer({required this.client, required this.networkInfo}) {
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..headers = {
        HttpHeaders.contentTypeHeader: ContentType.json.value,
        HttpHeaders.acceptHeader: ContentType.json.value,
      };
    client.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          final accessToken = await storage.getAccessToken();
          if (accessToken != null)
            options.headers[HttpHeaders.authorizationHeader] =
                '${EndPoints.prefixToken} $accessToken';
          return handler.next(options);
        },
        // onError: (DioException error, ErrorInterceptorHandler handler) async {
        //   if (error.response?.statusCode == 401) {
        //     try {
        //       final refreshToken = await storage.getRefreshToken();
        //       if (refreshToken != null) {
        //         final newToken = await _refreshAccessToken(refreshToken);
        //         if (newToken != null) {
        //           await storage.saveAuthTokenState(
        //               newToken[ApiKeys.accessToken], refreshToken);
        //           final requestOptions = error.requestOptions;
        //           requestOptions.headers[HttpHeaders.authorizationHeader] =
        //               '${EndPoints.prefixToken} $newToken';
        //           final response = await client.fetch(requestOptions);
        //           return handler.resolve(response);
        //         }
        //       }
        //     } catch (refreshError) {
        //       return handler.reject(error);
        //     }
        //   }
        //   return handler.next(error);
        // },
      ),
    );
    if (!kIsWeb) {
      client.httpClientAdapter = Http2Adapter(
        ConnectionManager(idleTimeout: const Duration(seconds: 10)),
      );
    }
  }
  // Future<dynamic> _refreshAccessToken(String refreshToken) async {
  //   final response = await post(EndPoints.refresh,
  //       body: {ApiKeys.refreshToken: refreshToken});
  //   return response;
  // }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return await _handleRequest(
      () => client.get(path,
          queryParameters: queryParameters, options: Options(headers: headers)),
    );
  }

  @override
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = true,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => client.post(
        path,
        data: formDataIsEnabled && body != null ? FormData.fromMap(body) : body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => client.delete(path,
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameters),
    );
  }

  @override
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool formDataIsEnabled = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _handleRequest(
      () => client.patch(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = true,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return await _handleRequest(
      () => client.put(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<dynamic> download(
    String path,
    String savePath, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return await _handleRequest(
      () => client.download(path, savePath,
          data: body,
          options: Options(headers: headers),
          queryParameters: queryParameters),
    );
  }

  Future<dynamic> _handleRequest(Future<Response> Function() request) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await request();
        return response.data;
      } on DioException catch (error) {
        _handleDioError(error);
      } catch (error) {
        throw UnknownException(StringEnums.unexpected_error.name);
      }
    } else {
      throw NoInternetConnectionException(
          StringEnums.no_internet_connection.name);
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw FetchDataException(StringEnums.network_error.name);
      case DioExceptionType.badResponse:
        _handleBadResponse(error);
        break;
      case DioExceptionType.cancel:
        throw RequestCancelledException(StringEnums.request_cancelled.name);
      default:
        throw UnknownException(StringEnums.unexpected_error.name);
    }
  }

  void _handleBadResponse(DioException error) {
    final dynamic responseData = error.response?.data;

    String? message;
    if (responseData is Map<String, dynamic>) {
      message = responseData["message"];
    } else if (responseData is String && responseData.contains('<html')) {
      final htmlMessage = RegExp(r'<h2>(.*?)<\/h2>', dotAll: true)
          .firstMatch(responseData)
          ?.group(1);
      message = htmlMessage?.trim();
    }

    switch (error.response?.statusCode) {
      case StatusCode.badRequest:
        throw BadRequestException(
            message ?? StringEnums.bad_request_error.name);
      case StatusCode.parameterError:
        throw ParamterErrorException(_handleValidationError(error));
      case StatusCode.unauthorized:
        throw UnauthorizedException(
            message ?? StringEnums.unauthorized_error.name);
      case StatusCode.forbidden:
        throw UnauthorizedException(
            message ?? StringEnums.forbidden_error.name);
      case StatusCode.notFound:
        throw NotFoundException(message ?? StringEnums.not_found_error.name);
      case StatusCode.conflict:
        throw ConflictException(message ?? StringEnums.conflict_error.name);
      case StatusCode.requestEntityTooLarge:
        throw PayloadTooLargeException(
            message ?? StringEnums.payload_too_large_error.name);
      case StatusCode.tooManyRequests:
        throw TooManyRequestsException(
            message ?? StringEnums.too_many_requests_error.name);
      case StatusCode.internalServerError:
        throw InternalServerErrorException(
            message ?? StringEnums.internal_server_error.name);
      case StatusCode.gatewayTimeout:
        throw GatewayTimeoutException(
            message ?? StringEnums.gateway_timeout_error.name);
      default:
        throw ServerException(message ?? StringEnums.unexpected_error.name);
    }
  }

  List<String> _handleValidationError(DioException error) {
    try {
      final dynamic list = error.response?.data["error"]?["details"];
      return list?.map<String>((e) => e["message"].toString()).toList() ??
          [StringEnums.unexpected_error.name];
    } catch (e) {
      return [StringEnums.unexpected_error.name];
    }
  }
}
