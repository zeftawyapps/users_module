 abstract class IBaseDataModel{
  // create to json method and factory forJson
  Map<String, dynamic> toJson();
  IBaseDataModel( );
  factory IBaseDataModel.fromJson(Map<String, dynamic> json , String id ) {
    throw UnimplementedError();
  }
  Map<String, dynamic>?  map = Map();

 }