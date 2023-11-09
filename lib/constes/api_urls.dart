
import '../https/commerce_http_urls.dart';

class ApiUrls{

  static   String BASE_URL = UsersUrlEnveiroment()!.baseUrl! ;
  static String testConnection = UsersUrlEnveiroment().endPoints.testConnection;
  static String logIn = UsersUrlEnveiroment().endPoints.logIn;
 static String logOut = UsersUrlEnveiroment().endPoints.logOut;
  static String createAccount = UsersUrlEnveiroment().endPoints.createAccount;
  static String createAccountAndProfile = UsersUrlEnveiroment().endPoints.createAccountAndProfile;
  static String getProfile = UsersUrlEnveiroment().endPoints.getProfile;
  static String updateProfile = UsersUrlEnveiroment().endPoints.updateProfile;
  static String updatePassword = UsersUrlEnveiroment().endPoints.updatePassword;
}