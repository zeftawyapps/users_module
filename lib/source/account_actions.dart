import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:users_module/constes/collections.dart';
import 'package:users_module/interface/actions.dart';
import 'package:users_module/utilis/firebase/firebase_and_storage_action.dart';

import '../modele/base_model/base_user_module.dart';
import '../utilis/firebase/firebase.dart';
import '../utilis/firebase/firestore_inputs.dart';

class UserProfileFirebaseActions implements IAccountActions{

FirestoreAndStorageActions? _firestoreAndStorageActions ;
  FireStoreAction? _fireStoreAction ;
  FirebaseLoadingData?_firebaseLoadingData ;

  File? file ;
Map<String, dynamic>? data ;

  UserProfileFirebaseActions({ this.file, this.data}){
    _fireStoreAction = FireStoreAction();
    _firebaseLoadingData = FirebaseLoadingData();
    _firestoreAndStorageActions = FirestoreAndStorageActions();
  }

  @override
  Future createProfileData({required  String id, required  Map<String, dynamic> data}) async {

    await   _fireStoreAction!.addDataCloudFirestore(collection: CollectionsName.usersAccountData, mymap: data);
  }

  @override
  Future<Map<String, dynamic>> getData(String id) async {

    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(CollectionsName.usersAccountData);
    QuerySnapshot  doc = await firebaseCollection.where( "id", isEqualTo:id ).limit(1).get() ;
    var data =   FirebaseLoadingData().getDataSnapshotOpjectToMap(doc).first;

   return   data ;
  }

  @override
  Future updateProfileData({  required  String id  }) async {
   String docid = await _firebaseLoadingData!.getCollrection(CollectionsName.usersAccountData).where("id", isEqualTo: id).get().then((value) => value.docs.first.id);

     return _firestoreAndStorageActions!.editeDataCloudFirestorWithUpload(collection: CollectionsName.usersAccountData, id: docid, mymap: data!, file: file, filedowloadurifieldname: "imguri");
  }

}