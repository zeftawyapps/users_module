import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:users_module/https/commerce_http_urls.dart';
import 'package:users_module/interface/base/account.dart';
import 'package:users_module/interface/http_acc.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/utilis/firebase/firebase_account.dart';

import '../../../constes/api_urls.dart';
import '../../../utilis/http_remotes/http_client.dart';
import '../../../utilis/http_remotes/http_methos_enum.dart';


class AuthHttpSource implements IHttpAuthentication {
  String? email;
  String? pass;
  String? name;

  AuthHttpSource({required String email, required String pass }) {
    this.email = email;
    this.pass = pass;

  }
  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  }) async {
    Map<String , dynamic >? allBody = {"email": email , "password": pass ,    }    ;
allBody.addAll(body!  );
    var user =     await UserHttpClient.UserzHttpClient(userToken: true).sendRequestObject(
        method: HttpMethod.POST,
        url: ApiUrls.createAccount,
        body:  allBody  ,
        cancelToken: CancelToken());
    var data = user ;
    return UsersBaseModel.formJson(data) ;
  }

  @override
  Future<UsersBaseModel> logIn() async {

    var user =     await UserHttpClient.UserzHttpClient(userToken: true).sendRequestObject(
        method: HttpMethod.POST,
        url: ApiUrls.logIn,
        body:  {"email": email , "password": pass}   ,
        cancelToken: CancelToken());

    var status = user["status"];
    if (status != 200) {
      throw Exception(user );
    }


    var data = user["data"];
 Map<String ,dynamic>userData = {};
    userData["email"] = email  ;
    userData["token"] = data["token"]  ;
    userData.addAll(data);

    return UsersBaseModel.formJson(userData!) ;
  }

  @override
  Future<void> logOut() async {

      await UserHttpClient.UserzHttpClient(userToken: true).sendRequestObject(
        method: HttpMethod.POST,
        url: ApiUrls.logOut ,
        body:  {"email": email , "password": pass}   ,
        cancelToken: CancelToken());


  }
}
