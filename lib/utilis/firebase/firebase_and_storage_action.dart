import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'firestore_inputs.dart';
import 'storage.dart';

class FirestoreAndStorageActions extends FireStoreAction with StorageActions {
  Future<dynamic> editeDataCloudFirestorWithUpload(
      {required String collection,
      required String id,
      required Map<String, dynamic> mymap,
      File? file,
      String? filedowloadurifieldname = "imguri"}) async {
    var data = await editDataCloudFirestore(
        id: id, collection: collection, mymap: mymap);

    if (file != null) {
      await uploadDataStoreage(file);
      String download = await downloadURLStoreage();

      data = await editDataCloudFirestore(
          collection: collection,
          id: id,
          mymap: {filedowloadurifieldname!: download});
    }
    return data;
  }

  Future<dynamic> editeDataCloudFirestorWithUploadSubCollection(
      {required String path ,

      required String id,
          String? image="imageUrl",
      required Map<String, dynamic> mymap,
      File? file,
      }) async {
    var data = await editDataCloudFirestoreSubColletion(

        id: id,
        path : path ,

        mymap: mymap);

    if (file != null) {
      await uploadDataStoreage(file);
      String download = await downloadURLStoreage();

      data = await editDataCloudFirestoreSubColletion(

          path: path,
          id: id,
          mymap: {image!: download});
    }
    return data;
  }

  Future<String> addDataCloudFirestorWithUpload(
      {required String collection,
      String? id,
      required Map<String, dynamic> mymap,
      File? file,
      String dir = "",
      String? filedowloadurifieldname = "imguri"}) async {
    String iddoc = await addDataCloudFirestore(
        id: id, collection: collection, mymap: mymap);

    if (file != null) {
      await uploadDataStoreage(file);
      String download = await downloadURLStoreage();
String docId ;
      if (id == null || id == ""){
        docId = iddoc ;
      }else {
        docId = id ;
      }
      editDataCloudFirestore(
          collection: collection,
          id: docId,
          mymap: {filedowloadurifieldname!: download});
    }
    return iddoc;
  }

  Future<String> addDataCloudFirestorWithUploadSubCollection(
      {required String path,
      String? id,
      required Map<String, dynamic> mymap,
      File? file,
      String dir = "",


      String? imageField = "imguri"}) async {
    String iddoc = await addDataCloudFirestoreSupCollection(

        id: id,
        path: path ,
        mymap: mymap);

    if (file != null) {
      await uploadDataStoreage(file);
      String download = await downloadURLStoreage();

      editDataCloudFirestoreSubColletion(

          path: path,
          id: id ?? iddoc,
          mymap: {imageField!: download});
    }
    return iddoc;
  }

  Future<void> editeDataCloudFirestorWithUploadAndReplacementSubCollection(
      {required String path,
      String dir = "",
      required String id,
      required Map<String, dynamic> mymap,
      File? file,
      String? iamgeField = "imguri",
      String? oldurl}) {
    return editDataCloudFirestoreSubColletion(
            id: id,

            path: path ,
            mymap: mymap,
           )
        .then((value) {
      if (file != null) {
        if (oldurl != "") {
          deleteDataStoreagefromurl(url: oldurl!);
        }
        uploadDataStoreage(file, dir: dir).then((value) {
          downloadURLStoreage().then((value) {
            editDataCloudFirestoreSubColletion(

                path: path,
                id: id,
                mymap: {iamgeField!:  value});
          });
        });
      }
    });
  }

  Future<void> editeDataCloudFirestorWithUploadAndReplacement(
      {required String collection,
      String dir = "",
      required String id,
      required Map<String, dynamic> mymap,
      File? file,
      String? filedowloadurifieldname = "imguri",
      String? oldurl}) {
    return editDataCloudFirestore(
      id: id,
      collection: collection,
      mymap: mymap,
    ).then((value) {
      if (file != null) {
        if (oldurl != "") {
          deleteDataStoreagefromurl(url: oldurl!);
        }
        uploadDataStoreage(file, dir: dir).then((value) {
          downloadURLStoreage().then((value) {
            editDataCloudFirestore(
                collection: collection,
                id: id,
                mymap: {filedowloadurifieldname!: value});
          });
        });
      }
    });
  }
}
