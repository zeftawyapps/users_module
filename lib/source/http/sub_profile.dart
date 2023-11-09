import 'package:dio/dio.dart';

import '../../constes/api_urls.dart';
import '../../utilis/http_remotes/http_client.dart';
import '../../utilis/http_remotes/http_methos_enum.dart';
import '../../utilis/models/base_model.dart';
import '../../utilis/result/result.dart';

class HttpSubProfile   {
  @override
  Future<UserResult<RemoteBaseModel, Map<String , dynamic>>>  setGameResult(
      Map<String , dynamic > body  ) async {
    return await UserHttpClient.UserzHttpClient(userToken: true).sendRequestResult(
        method: HttpMethod.POST,
        url: ApiUrls.testConnection,
        body: body  ,
        cancelToken: CancelToken());
  }
}