import 'package:users_module/modele/base_model/inhertid_models/user_model.dart';
import 'package:users_module/source/users_sourse.dart';

import '../utilis/models/base_model.dart';
import '../utilis/result/result.dart';

class UsersRepo {
  final UserModule _usersApi;

  UsersRepo(this._usersApi);

  Future< UserResult<EducationRemoteBaseModel, List<UserModule>>> getUsersUserFirebase() async {
    UsersSources  usersSources = UsersSources();
    var data = await usersSources.getUsers();
    return  UserResult(data: data , error: null);
  }
}
