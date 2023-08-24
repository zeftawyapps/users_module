import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:users_module/interface/account.dart';
import 'package:users_module/modele/base_model/base_user_module.dart';
import 'package:users_module/utilis/firebase/firebase_account.dart';


class EmailPassowrdAuthSource implements IAuthentication {
  String? email;
  String? pass;
  FirebaseAccount? _accountRegist;
  EmailPassowrdAuthSource({required String email, required String pass}) {
    this.email = email;
    this.pass = pass;
    _accountRegist = FirebaseAccount();
  }
  @override
  Future<UserCredential> createAccount() async {
    BaseUsersModel usersModel;
    var user = await _accountRegist!.createNewAccount(this.email!, pass!);
     return user;
  }

  @override
  Future<UserCredential> logIn() async {
    BaseUsersModel usersModel;
    var user = await _accountRegist!.logIn(this.email!, pass!);

     return user;
  }

  @override
  Future<void> logOut() async {
    await _accountRegist!.logOut();
  }
}
