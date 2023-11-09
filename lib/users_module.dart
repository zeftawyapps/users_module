library users_module;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

/// A Calculator.
class UsersTestConnection {
  Future  test()async{
   await Firebase.initializeApp();
   await FirebaseFirestore.instance.collection("testusers").add(({"tested":true}));
  }
}
