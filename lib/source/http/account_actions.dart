import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:users_module/constes/collections.dart';
import 'package:users_module/interface/base/actions.dart';
import 'package:users_module/utilis/firebase/firebase_and_storage_action.dart';

import '../../constes/api_urls.dart';
import '../../utilis/http_remotes/http_client.dart';
import '../../utilis/http_remotes/http_methos_enum.dart';


class UserProfileHttpActions implements IBaseAccountActions{



  File? file ;
Map<String, dynamic>? data ;

UserProfileHttpActions({ this.file, this.data}){

  }

  @override
  Future createProfileData({required  String id, required  Map<String, dynamic> data}) async {
    return await UserHttpClient.UserzHttpClient(userToken: true).sendRequestResult(
        method: HttpMethod.POST,
        url: ApiUrls.createAccountAndProfile,
        body: data   ,
        cancelToken: CancelToken());
   }

  @override
  Future<Map<String, dynamic>>  getData(String uid) async {
     return {};
  }
  @override
  Future <Map<String, dynamic>> updateProfileData({  required  String id  , Map<String , dynamic>? mapData  }) async {
    return {};
      }

}