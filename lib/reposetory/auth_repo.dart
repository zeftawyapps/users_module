import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_module/interface/base/account.dart';
import 'package:users_module/interface/http_acc.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/source/account_actions.dart';
import 'package:users_module/source/http/account_actions.dart';
import 'package:users_module/users_http_urls.dart';
import 'package:users_module/utilis/models/base_model.dart';
import 'package:users_module/utilis/result/result.dart';

import '../interface/base/actions.dart';
import '../modele/base_model/inhertid_models/user_model.dart';
import '../source/accountLoginLogout/http/auth_http_acc.dart';
import '../utilis/firebase/fireBase_exception_consts.dart';

class AuthRepo {
  IBaseAccountActions? _accountActions;
  late IBaseAuthentication _account;
  AuthRepo(IBaseAuthentication account) {
    _account = account;
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>> logIn() async {
    try {
      if (_account is IHttpAuthentication) {
        return _logInHttp();
      } else {
        return _logInFirebase();
      }
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>> createAccount(
      {UsersBaseModel? usersModel}) async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountHttp();
      } else {
        return _createAccountFirebase();
      }
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>> createAccountAndProfile(
      UsersBaseModel usersModel) async {
    try {
      if (_account is IHttpAuthentication) {
        return _createAccountAndProfileHttp(usersModel);
      } else {
        return _createAccountAndProfileFirebase(usersModel);
      }
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future lagOut() async {
    _account.logOut();
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>> _logInFirebase() async {
    try {
      var user = await _account.logIn();

      _accountActions = UserProfileFirebaseActions();
      UsersBaseModel usersModel =
          UserModule.formJson(await _accountActions!.getData(user.uid!));

      UsersHttpheader().setToken( user.token  ?? "");

      return UserResult.data(user);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>> _logInHttp() async {
    try {
      var user = await _account.logIn();

      return UserResult.data(user);
    }  catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: e.toString()  , status: "error"));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>>
      _createAccountHttp() async {
    try {
      var user = await _account.createAccount();

      return UserResult.data(user);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>>
      _createAccountFirebase() async {
    try {
      var user = await _account.createAccount();

      _accountActions = UserProfileFirebaseActions();
      var profileMapData = await _accountActions!.getData(user.uid!);
      if (profileMapData.isEmpty || profileMapData.length == 0) {
        await _accountActions!
            .createProfileData(id: user.uid!, data: user.toJson());

        UsersHttpheader().setToken(user.token ?? "");
      } else {
        user = UsersBaseModel.formJson(profileMapData);
      }
      // set token
      String token = user!.token!;
      UsersHttpheader().setToken(user.token! ?? "");

      return UserResult.data(user);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>>
      _createAccountAndProfileFirebase(UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount();
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";
      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);
      usersModel.uid = busersModel.uid;
      usersModel.email = busersModel.email;
      _accountActions = UserProfileFirebaseActions();

      await _accountActions!
          .createProfileData(id: usersModel.uid!, data: usersModel.toJson());
      // set token
      UsersHttpheader().setToken(user.token ?? "");
      return UserResult.data(usersModel);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel>>
      _createAccountAndProfileHttp(UsersBaseModel usersModel) async {
    try {
      var user = await _account.createAccount(body: usersModel.toJson());
      String userNameFromEmail = user.email!.split("@").first;
      String name = usersModel.name ?? user.name ?? "$userNameFromEmail";

      UsersBaseModel busersModel =
          UsersBaseModel(uid: user.uid, email: user.email, name: name);


      // set token
      UsersHttpheader().setToken(user.token ?? "");
      return UserResult.data(busersModel);
    }  catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: e.toString()  , status: "error"));
    }
  }
}
