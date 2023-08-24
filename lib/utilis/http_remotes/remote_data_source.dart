 import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:users_module/users_http_urls.dart';

import '../errors/http_errors/bass_errors.dart';
import '../errors/http_errors/errors/unknown_error.dart';
import '../models/base_model.dart';
import 'http_client.dart';
import 'http_methos_enum.dart';


class RemoteDataSource {
  Future<Either<BaseError, TModel>> requestUploadFile<TModel, TResponse>({
    required TResponse Function(dynamic) converter,
    required String url,
    required String fileKey,
    required String filePath,
    required MediaType mediaType,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    bool withTenants = false,
    required CancelToken cancelToken,
  }) async {
    // Send the request.
    final response = await HttpClient().upload<TModel>(
      url: url,
      fileKey: fileKey,
      filePath: filePath,
      fileName: filePath.substring(filePath.lastIndexOf('/') + 1),
      mediaType: mediaType,
      data: data,
      // headers: headers,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );

    // convert jsonResponse to model and return it
    var responseModel;
    if (response.isLeft()) {
      return Left((response as Left<BaseError, TModel>).value);
    } else if (response.isRight()) {
      responseModel = converter((response as Right<BaseError, TModel>).value);
      return Right(responseModel);
    }
    return Left(UnknownError());
  }

  /// [TModel] type of model response from server
  /// [TResponse]type of response from dart should be  dynamic map or List<dynamic>
  Future<Either<BaseModel, TModel>> request<TModel, TResponse>(
      {required TResponse Function(dynamic) converter,
        required HttpMethod method,
        required String url,
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        bool withAuthentication = false,
        required CancelToken cancelToken,
        String? baseUrl,
        bool? userToken}) async {

    /// show progress dialog every request

    // Send the request.
    Either<BaseModel, dynamic> response = await HttpClient(
        baseUrl: baseUrl ?? UsersHttpUrls().userBaseUrl, userToken: userToken ?? false)
        .sendRequest<dynamic>(
      method: method,
      url: url,
      queryParameters: queryParameters ?? {},
      body: body,
      cancelToken: cancelToken,
    );
    // convert jsonResponse to model and return it
    var responseModel;
    if (response.isLeft()) {
      return Left((response as Left<BaseModel, TResponse>).value);
    } else if (response.isRight()) {
      try {
        responseModel =
            converter((response as Right<BaseModel, TResponse>).value);
        return Right(responseModel);
      } catch (e) {
        print(e);
        return Left(BaseModel());
      }
    }
    return Left(BaseModel());
  }

 }
