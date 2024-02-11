import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:users_module/utilis/http_remotes/http_client.dart';

import '../constes/api_urls.dart';
import '../constes/collections.dart';
import '../interface/base/actions.dart';
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


  Future<UserResult<EducationRemoteBaseModel, List<Map<String, dynamic>>>> getProfileSubData(
      {  required String subCollection ,  required String docId, Query Function(Query query)? query}) async {
    try {
      String collection = CollectionsName.usersAccountData;
      var path = "$collection/$docId/$subCollection";
      var profileMapData =
      await _Actions!.getData(path: path, queryBuilder: query);
      return UserResult.data(profileMapData);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }


  Future<UserResult<EducationRemoteBaseModel, EducationRemoteBaseModel>> setGameResult (
      {required Map<String , dynamic >body   }) async {
    var result = await HttpSubProfile().setGameResult(body);
    EducationRemoteBaseModel? data, error;

    result.pick(onData: (v) {
      data = EducationRemoteBaseModel(data: v["data"]);
    }, onError: (e) {
      error = EducationRemoteBaseModel(message: e.message, status: e.status);
    });
    UserResult<EducationRemoteBaseModel, EducationRemoteBaseModel> dresult =
    UserResult(data: data, error: error);
    return dresult;
  }



}
