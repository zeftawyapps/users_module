import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IAccountActions{
  Future createProfileData({ required  String id,required  Map<String, dynamic> data});
  Future updateProfileData({ required  String id });
  Future<Map<String , dynamic>>getData(String id );
}

abstract class IProfileSubDataActions{
  Future createProfileData({   required  String path     , required  Map<String, dynamic> data});
  Future updateProfileData({ required String id ,  required  String path  , required  Map<String, dynamic> data });
  Future deleteProfileData({ required  String path  });
  Future<List<Map<String , dynamic>>>getData({ required  String path, Query Function(Query query)? queryBuilder});
}