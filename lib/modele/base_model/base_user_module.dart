import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users_module/modele/base_model/interface_userModel.dart';

  class BaseUsersModel implements IuserModel {
 static const  String idKey ="id" ;
 static const  String? nameKey = "name";
 static   const  String? emailKey ="email";

  String? id ;
  String? name;
  String? email;
BaseUsersModel ({this.name , this.id , this.email });


 BaseUsersModel.  formJson(Map<String , dynamic> json ){
  id = json['id']== null ? null  : json['id'] ;
  name = json['name']== null ? null  : json['name'] ;
  email = json['email']== null ? null  : json['email'] ;
 map = json ;
 }
 @mustBeOverridden
  Map<String, dynamic> toJson() {
    final _data =   map ;
    _data['id'] = id ;
    _data['name'] = name ;
    _data['email'] = email ;
    return _data ;
  }

  @override
  Map<String, dynamic>  map = Map();
}