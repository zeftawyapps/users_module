import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:users_module/utilis/http_remotes/http_client.dart';

import '../constes/api_urls.dart';
import '../constes/collections.dart';
import '../interface/actions.dart';
import '../modele/base_model/base_user_module.dart';
import '../source/account_actions.dart';
import '../source/http/sub_profile.dart';
import '../utilis/firebase/fireBase_exception_consts.dart';
import '../utilis/http_remotes/http_methos_enum.dart';
import '../utilis/models/base_model.dart';
import '../utilis/result/result.dart';
import '../utilis/shardeprefrance/shard_check.dart';

class ProfileSubDataRebo {
  SharedPrefranceChecking? _sharedRefrance;
  late IProfileSubDataActions _Actions;
  ProfileSubDataRebo(IProfileSubDataActions accountActions) {
    _sharedRefrance = SharedPrefranceChecking();
    _Actions = accountActions;
  }


  Future<UserResult<RemoteBaseModel, List<Map<String, dynamic>>>> getProfileSubData(
      {  required String subCollection ,  required String docId, Query Function(Query query)? query}) async {
    try {
      String collection = CollectionsName.usersAccountData;
      var path = "$collection/$docId/$subCollection";
      var profileMapData =
      await _Actions!.getData(path: path, queryBuilder: query);
      return UserResult.data(profileMapData);
    } on FirebaseException catch (e) {
      return UserResult.error(
          RemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }


  Future<UserResult<RemoteBaseModel, RemoteBaseModel>> setGameResult (
      {required Map<String , dynamic >body   }) async {
    var result = await HttpSubProfile().setGameResult(body);
    RemoteBaseModel? data, error;

    result.pick(onData: (v) {
      data = RemoteBaseModel(data: v["data"]);
    }, onError: (e) {
      error = RemoteBaseModel(message: e.message, status: e.status);
    });
    UserResult<RemoteBaseModel, RemoteBaseModel> dresult =
    UserResult(data: data, error: error);
    return dresult;
  }



}
