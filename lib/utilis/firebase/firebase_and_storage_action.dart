import 'dart:io';



import 'package:flutter/cupertino.dart';
import 'package:users_module/utilis/firebase/storage.dart';

import 'firestore_inputs.dart';

   class FirestoreAndStorageActions extends FireStoreAction  with  StorageActions {

     Future<Object> editeDataCloudFirestorWithUpload({required String collection,
       required String id,
       required Map<String, dynamic> mymap,
       File? file,
       String? filedowloadurifieldname = "imguri"})async{
    var data =     await  editDataCloudFirestore(
           id: id, collection: collection, mymap: mymap);

        if (file != null) {
          await  uploadDataStoreage(file) ;
          String download =    await    downloadURLStoreage() ;

    data =   await       editDataCloudFirestore(
              collection: collection,
              id: id ,
              mymap: {filedowloadurifieldname!: download});

        }
       return data ;
     }


  Future<String> addDataCloudFirestorWithUpload({required String collection,
     String? id,
    required Map<String, dynamic> mymap,
    File? file,String dir ="" ,
    String? filedowloadurifieldname = "imguri"}) async {
    String iddoc = await   addDataCloudFirestore(id: id , collection: collection, mymap: mymap) ;

      if (file != null) {
       await  uploadDataStoreage(file) ;
     String download =    await    downloadURLStoreage() ;

            editDataCloudFirestore(
                collection: collection,
                id: id?? iddoc ,
                mymap: {filedowloadurifieldname!: download});

      }
return iddoc ;
  }

  Future<void> editeDataCloudFirestorWithUploadAndReplacement(
      {required String collection,String dir = "" ,
        required String id,
        required Map<String, dynamic> mymap,
        File? file,
        String? filedowloadurifieldname = "imguri", String? oldurl}) {
    return editDataCloudFirestore(id: id, collection: collection, mymap: mymap)
        .then((value) {
      if (file != null) {
        if (oldurl != "") {
          deleteDataStoreagefromurl(url: oldurl!);
        }
        uploadDataStoreage(file,dir: dir ).then((value) {
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