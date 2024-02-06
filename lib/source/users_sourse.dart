import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:users_module/constes/collections.dart';
import 'package:users_module/interface/base/actions.dart';
import 'package:users_module/modele/base_model/inhertid_models/user_model.dart';
import 'package:users_module/utilis/firebase/firebase_and_storage_action.dart';

import '../modele/base_model/base_user_module.dart';
import '../utilis/firebase/firebase.dart';
import '../utilis/firebase/firestore_inputs.dart';

class UsersSources  {
  FirestoreAndStorageActions? _firestoreAndStorageActions;
  FireStoreAction? _fireStoreAction;
  FirebaseLoadingData? _firebaseLoadingData;

  File? file;
  Map<String, dynamic>? data;

  UserProfileFirebaseActions( ) {
    _fireStoreAction = FireStoreAction();
    _firebaseLoadingData = FirebaseLoadingData();
    _firestoreAndStorageActions = FirestoreAndStorageActions();
  }

  // get users
  Future<List<UserModule>> getUsers() async {
    CollectionReference firebaseCollection;
    firebaseCollection =
        FirebaseFirestore.instance.collection(CollectionsName.usersAccountData);
    QuerySnapshot doc =
        await firebaseCollection.get();

    var data = FirebaseLoadingData().getDataSnapshotOpjectToMap(doc);
    var result = data.length;
    if (result == 0) {
      return [];
    } else {
      return data.map((e) => UserModule.formJson(e)).toList();
    }
  }

 }
