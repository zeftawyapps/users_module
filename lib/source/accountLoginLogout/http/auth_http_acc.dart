import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:users_module/https/commerce_http_urls.dart';
import 'package:users_module/interface/account.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/utilis/firebase/firebase_account.dart';

import '../../../constes/api_urls.dart';
import '../../../utilis/http_remotes/http_client.dart';
import '../../../utilis/http_remotes/http_methos_enum.dart';


class EmailPassowrdAuthHttpSource implements IAuthentication {
  String? email;
  String? pass;
  String? name;

  EmailPassowrdAuthHttpSource({required String email, required String pass }) {
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
    var data = user[UsersUrlEnveiroment().endPoints!.data];
    return UsersBaseModel.formJson(data) ;
  }

  @override
  Future<UsersBaseModel> logIn() async {

    var user =     await UserHttpClient.UserzHttpClient(userToken: true).sendRequestObject(
        method: HttpMethod.POST,
        url: ApiUrls.logIn,
        body:  {"email": email , "password": pass}   ,
        cancelToken: CancelToken());
 var data = user["data"];
    return UsersBaseModel.formJson(data) ;
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
