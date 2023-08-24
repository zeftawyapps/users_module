abstract class IAccountActions{
  Future createProfileData({ required  String id,required  Map<String, dynamic> data});
  Future updateProfileData({ required  String id });
  Future<Map<String , dynamic>>getData(String id );
}