library users_module;

import 'package:cloud_firestore/cloud_firestore.dart';

/// A Calculator.
class UsersTestConnection {
  void  test(){
    FirebaseFirestore.instance.collection("testusers").add(({"tested":true}));
  }
}
