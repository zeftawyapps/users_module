import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


class JsonFileManger{

  String response ='';
  List _items = [];
  dynamic data ;

  bool   fileExists = false ;



 Future<void > setfileRedy(String ass , String name ){
   return _CopyFileFromAsset(ass, name);
 }
  Future <  dynamic> readFile(String path,String filename)async{
    Directory?  directory = await getExternalStorageDirectory();
    File file = new File(directory!.path + "/" + filename);
 fileExists = await    file.exists() ;
 if (!fileExists){
      await  setfileRedy( path,filename);}
else {
  response = file.readAsStringSync(); }
  //   response = await rootBundle.loadString('$path$filename');

return   json.decode(response) ;
  }
  Future < dynamic > readFileFromAsset (String path  )async{
    File file = File('$path');
  //  response = await  file.readAsString();
    response = await rootBundle.loadString('$path');

    return json.decode(response) ;
  }
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory!.path;
  }
  Future<void  >  _CopyFileFromAsset (String asset,String filename  ) async {
    Directory?  directory = await getExternalStorageDirectory();
    File file = new File(directory!.path + "/" + filename);
    response = await rootBundle.loadString('$asset$filename');

    file.createSync();
    bool   fileExists = true;
    file.writeAsStringSync(response);

  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
  bool   fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }
late   File jsonFile;

  void writeToFile(String r ,  String filename  ) async {
    print("Writing to file!");


      print("File exists");
      Directory?  directory = await getExternalStorageDirectory();
      File file = new File(directory!.path + "/" + filename);
      file.writeAsStringSync(r);


  }
 }

