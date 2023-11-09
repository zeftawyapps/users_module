import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:users_module/constes/collections.dart';
import 'package:users_module/interface/actions.dart';
import 'package:users_module/utilis/firebase/firebase_and_storage_action.dart';

import '../modele/base_model/base_user_module.dart';
import '../utilis/firebase/firebase.dart';
import '../utilis/firebase/firestore_inputs.dart';

class UserProfileFirebaseSubDataActions implements IProfileSubDataActions{

  FirestoreAndStorageActions? _firestoreAndStorageActions ;
  FireStoreAction? _fireStoreAction ;
  FirebaseLoadingData?_firebaseLoadingData ;

  File? file ;
  Map<String, dynamic>? data ;

  UserProfileFirebaseSubDataActions({ this.file, this.data}){
    _fireStoreAction = FireStoreAction();
    _firebaseLoadingData = FirebaseLoadingData();
    _firestoreAndStorageActions = FirestoreAndStorageActions();
  }

  @override
  Future createProfileData({ required  String path  ,  required  Map<String, dynamic> data}) async {

    await   _fireStoreAction!.addDataCloudFirestoreSupCollection(path : path  ,  mymap: data );
  }

  @override
  Future<List<Map<String , dynamic>>>getData({ required  String path, Query Function(Query query)? queryBuilder})async {
 var map = await  _firebaseLoadingData!.loadDataWithQuery(path: path, queryBuilder: queryBuilder
    ,  builder: (data, id) => data
    );

  return map.map((e) => e as Map<String, dynamic>).toList();
  }
  @override
  Future updateProfileData({ required id ,  required  String path  , required  Map<String, dynamic> data }) async {
    await   _fireStoreAction!.editDataCloudFirestoreSubColletion(path : CollectionsName.usersAccountData , id:  id ,  mymap: data );

  }

  @override
  Future deleteProfileData({required String path}) {
    // TODO: implement deleteProfileData
    throw UnimplementedError();
  }

}