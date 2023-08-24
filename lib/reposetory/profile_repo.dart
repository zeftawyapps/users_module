import 'package:cloud_firestore/cloud_firestore.dart';

import '../interface/actions.dart';
import '../modele/base_model/base_user_module.dart';
import '../source/account_actions.dart';
import '../utilis/firebase/fireBase_exception_consts.dart';
import '../utilis/models/base_model.dart';
import '../utilis/result/result.dart';
import '../utilis/utilt_functions/util_functions.dart';

class ProfilRebo{

  SharedPrefranceChecking ? _sharedRefrance ;
 late IAccountActions _accountActions;
  ProfilRebo(IAccountActions accountActions){
    _sharedRefrance = SharedPrefranceChecking();
     _accountActions = accountActions;
  }
  Future<Result<BaseModel,  Map<String , dynamic >>> editProfile(  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();

      var profileMapData =    await _accountActions.updateProfileData(id: uid   );

      var profildata =    profileMapData ;
      return Result.data(profildata);
    } on FirebaseException catch (e) {
      return Result.error(
          BaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }
  Future<Result<BaseModel, BaseUsersModel >> getProfile(  ) async {
    try {
      String uid =  await _sharedRefrance!.getUid();
      _accountActions = UserProfileFirebaseActions();
      var profileMapData =    await _accountActions!.getData(uid );
      BaseUsersModel  usersModel = BaseUsersModel . formJson(profileMapData);
      return Result.data(usersModel);
    } on FirebaseException catch (e) {
      return Result.error(
          BaseModel(message: handilExcepstons(e.code), status: e.code));
    }
  }

}