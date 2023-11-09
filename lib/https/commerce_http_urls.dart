// create class UsersHttpUrls use singleton pattern


class UsersUrlEnveiroment {

  String? baseUrl = "https://eventapp-api.herokuapp.com/api/v1";

 var   _endPoints ;
 var _response ;
  static final UsersUrlEnveiroment _baseUrlEnvet = UsersUrlEnveiroment._internal();
  factory UsersUrlEnveiroment ({String? baseUrl}) {

    return _baseUrlEnvet;
  }

  factory UsersUrlEnveiroment .urls({ String? baseUrl ,  String ? testConnection
    , String ? logIn , String ? createAccount , String ? createAccountAndProfile
    , String ? getProfile , String ? updateProfile , String ? updatePassword ,}) {
      _baseUrlEnvet.baseUrl = baseUrl ;

    _baseUrlEnvet._endPoints = (
    testConnection: "${_baseUrlEnvet.baseUrl}${testConnection ??"/testConnection"}",
    logIn: "${_baseUrlEnvet.baseUrl}${logIn??"/login"}",

    createAccount: "${_baseUrlEnvet.baseUrl}${createAccount??"/createAcc"}",
    createAccountAndProfile: "${_baseUrlEnvet.baseUrl}${createAccountAndProfile??"/creatAccAndprof"}",
    getProfile: "${_baseUrlEnvet.baseUrl}${getProfile??"/getProf"}",
    updateProfile: "${_baseUrlEnvet.baseUrl}${updateProfile??"/update"}",
    updatePassword: "${_baseUrlEnvet.baseUrl}${updatePassword??"updatePass"}",
    data:   "data",
    error:  "error",
    message: "message",
    status:  "status,"

    ) ;
    return _baseUrlEnvet;
  }
  UsersUrlEnveiroment._internal();

   get endPoints => _endPoints!;
    get response => _response!;
}


// create class UsersHttpheader use singleton pattern
class QuizHttpHeader {
  // create instance UsersHttpheader
  static final QuizHttpHeader _instance = QuizHttpHeader._internal();

  // create factory UsersHttpheader
  factory QuizHttpHeader() => _instance;
  void setToken(String token) {
    _usertoken = token;
  }

  String get usertoken => _usertoken;
  // create UsersHttpheader._internal
  QuizHttpHeader._internal();

  String _usertoken = '';
}
