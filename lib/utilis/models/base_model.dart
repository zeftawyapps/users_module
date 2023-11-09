import 'package:users_module/https/commerce_http_urls.dart';

class RemoteBaseModel<T> {

  RemoteBaseModel({
    this.status,
    this.message,this.data
  });
  String? status;
  String? message;
T?data ;
  factory RemoteBaseModel.fromJson(Map<String, dynamic> json) {
    return RemoteBaseModel(
      status: json['${UsersUrlEnveiroment().endPoints.status}']??"" as String?,
      message: json['${UsersUrlEnveiroment().endPoints.message}']??"" as String?,
      data: json['${UsersUrlEnveiroment().endPoints.data}']??"" as T?,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['${UsersUrlEnveiroment().endPoints.status}'] = status;
    _data['${UsersUrlEnveiroment().endPoints.message}'] = message;
    _data['${UsersUrlEnveiroment().endPoints.data}'] = data;
    return _data;
  }
}
