import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/base/actions.dart';
import '../interface/base/actions.dart';
import '../modele/base_model/base_user_module.dart';
import '../source/account_actions.dart';
import '../utilis/firebase/fireBase_exception_consts.dart';
import '../utilis/models/base_model.dart';
import '../utilis/result/result.dart';
import '../utilis/shardeprefrance/shard_check.dart';

class ProfilRebo{

  SharedPrefranceChecking ? _sharedRefrance ;
 late IBaseAccountActions _accountActions;
  ProfilRebo(IBaseAccountActions accountActions){
    _sharedRefrance = SharedPrefranceChecking();
     _accountActions = accountActions;
  }
   Future<UserResult<EducationRemoteBaseModel, UsersBaseModel >> getProfile(  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();
      _accountActions = UserProfileFirebaseActions();
      var profileMapData =    await _accountActions!.getData(uid );
      UsersBaseModel  usersModel = UsersBaseModel . formJson(profileMapData);
      return UserResult.data(usersModel);
    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }
  Future<UserResult<EducationRemoteBaseModel, UsersBaseModel >> editProfile( Map<String ,dynamic> map  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();
      _accountActions = UserProfileFirebaseActions();
       var result  =   await _accountActions.updateProfileData(id: uid , mapData: map );
      UsersBaseModel  usersModel = UsersBaseModel . formJson(result);
      return UserResult.data(usersModel);

    } on FirebaseException catch (e) {
      return UserResult.error(
          EducationRemoteBaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }
}