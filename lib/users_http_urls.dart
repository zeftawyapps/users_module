// create class UsersHttpUrls use singleton pattern
class UsersHttpUrls {
  // create instance UsersHttpUrls
  static final UsersHttpUrls _instance = UsersHttpUrls._internal();

  // create factory UsersHttpUrls
  factory UsersHttpUrls() => _instance;

  // create UsersHttpUrls._internal
  UsersHttpUrls._internal();

  // create method getUsers
  String getUsers() => 'https://jsonplaceholder.typicode.com/users';
  // add user base url variable
  String userBaseUrl = '';

}
// create class UsersHttpheader use singleton pattern
class UsersHttpheader {
  // create instance UsersHttpheader
  static final UsersHttpheader _instance = UsersHttpheader._internal();

  // create factory UsersHttpheader
  factory UsersHttpheader() => _instance;
void setToken(String token) {

    _usertoken = token;
  }
  String get usertoken => _usertoken;
  // create UsersHttpheader._internal
  UsersHttpheader._internal();

  String _usertoken = '';

}