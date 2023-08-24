import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthentication{

 Future<UserCredential>  createAccount();
 Future <UserCredential> logIn();
Future<void> logOut();
}