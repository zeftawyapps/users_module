import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_module/interface/account.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/source/account_actions.dart';
import 'package:users_module/users_http_urls.dart';
import 'package:users_module/utilis/models/base_model.dart';
import 'package:users_module/utilis/result/result.dart';

import '../modele/base_model/inhertid_models/user_model.dart';
import '../utilis/firebase/fireBase_exception_consts.dart';
import '../utilis/utilt_functions/util_functions.dart';

class AuthRepo   {
  UserProfileFirebaseActions? _accountActions;
 late IAuthentication _account ;
  AuthRepo(IAuthentication account) {
    _account = account ;
  }

  Future<Result<BaseModel,    BaseUsersModel   >> logIn( ) async {
    try {
    var user    = await _account.logIn();
    BaseUsersModel busersModel= BaseUsersModel(id: user.user!.uid , email: user.user!.email);
      _accountActions = UserProfileFirebaseActions();
      BaseUsersModel  usersModel =   UserModule.formJson(await _accountActions!.getData(busersModel.id!));
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          BaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }
  Future<Result<BaseModel, BaseUsersModel>> createAccount( ) async {
    try {
     var user = await _account.createAccount();
     BaseUsersModel usersModel = BaseUsersModel(id: user.user!.uid , email: user.user!.email);
     _accountActions = UserProfileFirebaseActions();
      await _accountActions!.createProfileData( id : usersModel.id!  , data:  usersModel.toJson());
     UsersHttpheader().setToken( await user.user!.getIdToken());
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          BaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }
  Future<Result<BaseModel, BaseUsersModel>> createAccountAndProfile(  BaseUsersModel usersModel ) async {
    try {
     var user  = await _account.createAccount();
     BaseUsersModel busersModel = BaseUsersModel(id: user.user!.uid , email: user.user!.email);
     usersModel.id = busersModel.id ;
     usersModel.email = busersModel.email ;
      _accountActions = UserProfileFirebaseActions();

      await _accountActions!.createProfileData(id: usersModel.id! , data:  usersModel.toJson());
      // set token
         UsersHttpheader().setToken( await user.user!.getIdToken());
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          BaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

  Future lagOut( ) async {
    _account.logOut();
  }
}
