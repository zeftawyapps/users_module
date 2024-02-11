import 'dart:io';
 import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http_parser/http_parser.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

 import '../../constes/api_urls.dart';
import '../../https/commerce_http_urls.dart';
import '../errors/http_errors/bass_errors.dart';
import '../errors/http_errors/errors/bad_request_error.dart';
import '../errors/http_errors/errors/cancel_error.dart';
import '../errors/http_errors/errors/conflict_error.dart';
import '../errors/http_errors/errors/connection_error.dart';
import '../errors/http_errors/errors/forbidden_error.dart';
import '../errors/http_errors/errors/format_error.dart';
import '../errors/http_errors/errors/internal_server_error.dart';
import '../errors/http_errors/errors/not_found_error.dart';
import '../errors/http_errors/errors/socket_error.dart';
import '../errors/http_errors/errors/timeout_error.dart';
import '../errors/http_errors/errors/unauthorized_error.dart';
import '../errors/http_errors/errors/unknown_error.dart';
import '../models/base_model.dart';
import '../result/result.dart';
import 'http_methos_enum.dart';

class UserHttpClient {
  static late Dio _client;

  Dio get instance => _client;
  String? baseUrl;
  bool? userToken;

  UserHttpClient.UserzHttpClient({this.baseUrl   , userToken = false}) {
    baseUrl = ApiUrls.BASE_URL;
    BaseOptions _options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30000),
      receiveTimeout: Duration(milliseconds: 30000),
      sendTimeout: Duration(milliseconds: 30000),
      responseType: ResponseType.json,
      baseUrl: baseUrl!,
    );
    _client = Dio(_options);
    _client.interceptors.add(PrettyDioLogger());
    if (userToken) {
      String authorizationHeader = "Basic " +
         QuizHttpHeader().usertoken;
      _client.options.headers["Authorization"] = authorizationHeader;
      _client.options.headers["Content-Type"] = "application/json";
      _client.options.headers["Accept"] = "*/*";
      _client.options.headers["Accept-Encoding"] = "gzip, deflate, br";
      _client.options.headers["Connection"] = "keep-alive";
      _client.options.headers["Content-Length"] = "0";
      // _client.options.headers["Content-Type"] = "application/json";
    }
  }

  Future< T  >  sendRequestValue<T>({
    required HttpMethod method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response response;
    try {
      var headders = headers?? _client.options.headers;
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headers),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
      }

        return response.data;
      }  catch (e) {

        throw e ;
      }
    }


  Future<UserResult<EducationRemoteBaseModel, Map<String , dynamic> >> sendRequestResult<T>({
    required HttpMethod method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response<Map<String , dynamic>> response;
    var headders = headers?? _client.options.headers;
    try {
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        /// dismiss progress dialog

        // Get the decoded json
        Map<String ,dynamic> data = { "status" : response.data!["status"]  , "data": response.data!["data"]  } ;
        return UserResult.data (  data );
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return  UserResult. error (EducationRemoteBaseModel(message: e.message));
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return UserResult. error(EducationRemoteBaseModel());
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e.error}");
      var error = {"massage": e.response?.data["message"] ?? ""   };
      return UserResult. error(EducationRemoteBaseModel(message: error["massage"] , status: "error" , data:  "null"));
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      return UserResult. error(EducationRemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      /// dismiss progress dialog

      return UserResult. error(EducationRemoteBaseModel(message: e.message));
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      return UserResult. error(EducationRemoteBaseModel(message: e.toString()));
    }
  }

  Future< Map<String ,dynamic >> sendRequestObject<T>({
    required HttpMethod method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response<T> response;
    try {
      var headders = headers?? _client.options.headers;

      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers: headders),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        /// dismiss progress dialog

        // Get the decoded json

      return  {    "status" : "done" , "data":  response.data  };
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return  {"massage": e.message , "status" : "error" , "data":  "null"};
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return  {"massage": e.toString() , "status" : "error" , "data":  "null"};
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e.error}");
      var error = {"massage": e.response?? ""  , "status" : "error" , "data":  "null"
      ,"erroeCode":e.error
      };
      return error ;
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      return  {"massage": e.message , "status" : "error" , "data":  "null"};
    } on HttpException catch (e) {
      /// dismiss progress dialog

      throw e ;
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      return  {"massage": e.toString() , "status" : "error" , "data":  "null"};
    }
  }
  Future<Either<EducationRemoteBaseModel, T>> sendRequest<T>({
    required HttpMethod method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required CancelToken cancelToken,
  }) async {
    // Get the response from the server
    Response response;
    try {
      var headders = headers?? _client.options.headers;
      switch (method) {
        case HttpMethod.GET:
          response = await _client.get(
            url,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,

          );
          break;
        case HttpMethod.POST:
          response = await _client.post(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.PUT:
          response = await _client.put(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.DELETE:
          response = await _client.delete(
            url,
            data: body,
            queryParameters: queryParameters,
            options: Options(headers:  headders),
            cancelToken: cancelToken,
          );
          break;
      }
      try {
        /// dismiss progress dialog

        // Get the decoded json
        return Right(response.data!);
      } on FormatException catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return Left(EducationRemoteBaseModel(message: e.message));
      } catch (e) {
        /// dismiss progress dialog

        debugPrint(e.toString());
        return Left(EducationRemoteBaseModel());
      }
    }
    // Handling errors
    on DioError catch (e) {
      /// dismiss progress dialog

      print("e.response ${e.error}");
      return Left(EducationRemoteBaseModel.fromJson(e.response?.data));
    }

    // Couldn't reach out the server
    on SocketException catch (e) {
      /// dismiss progress dialog

      return Left(EducationRemoteBaseModel(message: e.message));
    } on HttpException catch (e) {
      /// dismiss progress dialog

      return Left(EducationRemoteBaseModel(message: e.message));
    } catch (e, s) {
      /// dismiss progress dialog

      print('catch error s$s');
      return Left(EducationRemoteBaseModel(message: e.toString()));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, T>> upload<T>({
    required String url,
    required String fileKey,
    required String filePath,
    required String fileName,
    required MediaType mediaType,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> dataMap = {};
    if (data != null) {
      dataMap.addAll(data);
    }
    dataMap.addAll({
      fileKey: await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: mediaType,
      )
    });
    try {
      Response<T> response = await _client.post(
        url,
        data: FormData.fromMap(dataMap),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );

      try {
        // Get the decoded json
        return  UserResult.data(response.data!);
      } on FormatException {
        return UserResult.error( EducationRemoteBaseModel(message: FormatError().toString() ,));
      } catch (e) {
        return  UserResult.error( EducationRemoteBaseModel(message: e.toString() ,));
      }
    }
    // Handling errors
    on DioError catch (e) {
    return UserResult.error( EducationRemoteBaseModel (message: e.message));
    }
    //  return Left(_handleDioError(e));


    // Couldn't reach out the server
    on SocketException {
      return  UserResult.error( EducationRemoteBaseModel(message: SocketError().toString() ,));
    } on HttpException {
      return  UserResult.error( EducationRemoteBaseModel(message: ConnectionError().toString() ,));
    } catch (e, s) {
      print('catch error s$s');
      return  UserResult.error( EducationRemoteBaseModel(message: e.toString() ,));
    }
  }

  }
