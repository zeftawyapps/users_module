import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


class JsonAssetReader{


  Map<String , dynamic >? _data ;
String _path = '';
  bool   fileExists = false ;
JsonAssetReader({required String path }){
  this._path = path ;

  _data =  _readFileFromAsset(path) as Map<String, dynamic> ;
}
  get data => _data ;


   Future < dynamic > _readFileFromAsset (String path  )async{

    //  response = await  file.readAsString();
   var  response = await rootBundle.loadString('$path');

    return json.decode(response) ;
  }
   }

