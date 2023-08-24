import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseLoadingData {
  CollectionReference getCollrection(String collection) {
    return FirebaseFirestore.instance.collection(collection);
  }

  Future<QuerySnapshot> loadDataAsFuture(String collection) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return await firebaseCollection.get();
  }

  Stream<QuerySnapshot> loadDataAsStream(String collection) {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collection);
    return firebaseCollection.snapshots();
  }

  List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> getDataSnapshotToMap(
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];
    QuerySnapshot qs = snapshot.data!;
    qs.docs.map((doc) {
      getlist.add(doc.data()! as Map<String, dynamic>);
    }).toList();

    return getlist;
  }

  List<Map<String, dynamic>> getDataSnapshotOpjectToMap(QuerySnapshot snapshot,
      {String? idcell}) {
    List<Map<String, dynamic>> getlist = <Map<String, dynamic>>[];

    QuerySnapshot qs = snapshot;
    qs.docs.map((doc) {
      Map<String, dynamic> docmap = Map();
      docmap = doc.data()! as Map<String, dynamic>;
      if (idcell != null) {
        docmap.addAll({idcell: doc.id});
      }
      getlist.add(docmap);
    }).toList();

    return getlist;
  }

  Future<Map<String, dynamic>?> getSingleDataRow(
      String collectin, String id) async {
    CollectionReference firebaseCollection;
    firebaseCollection = FirebaseFirestore.instance.collection(collectin);
    DocumentSnapshot doc = await firebaseCollection.doc(id).get();

    return doc.data() as Map<String, dynamic>;
  }
}
