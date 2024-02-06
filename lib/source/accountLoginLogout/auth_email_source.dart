import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:users_module/interface/base/account.dart';
import 'package:users_module/interface/firebase_acc.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/utilis/firebase/firebase_account.dart';


class EmailPassowrdAuthSource implements IFirebaseAuthentication {
  String? email;
  String? pass;
  String? name;
  FirebaseAccount? _accountRegist;
  EmailPassowrdAuthSource({required String email, required String pass, this.name}) {
    this.email = email;
    this.pass = pass;
    _accountRegist = FirebaseAccount();
  }
  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  }) async {

    var user = await _accountRegist!.createNewAccount(this.email!, pass!  );
   await  user.user!.updateDisplayName(this.name?? "user");
UsersBaseModel usersModel;
    String token = await user.user!.getIdToken() ?? "";
    usersModel = UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: token);
    return usersModel;
  }

  @override
  Future<UsersBaseModel> logIn() async {
    UsersBaseModel usersModel;
    var user = await _accountRegist!.logIn(this.email!, pass!);
    String token = await user.user!.getIdToken() ?? "";
usersModel = UsersBaseModel(name: user.user!.displayName, email: user.user!.email, uid: user.user!.uid, token: token);
     return usersModel;
  }

  @override
  Future<void> logOut() async {
    await _accountRegist!.logOut();
  }
}
