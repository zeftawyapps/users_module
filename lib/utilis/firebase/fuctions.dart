import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/cell_models/row_cells.dart';
 class FirebaseCustomFuncitons{
  String getdate(DateTime date){
    return  DateFormat.yMMMd().format(date); // Apr 8, 2020

  }

  String getdatefromellesecont(int  seconts){
    DateTime Datetimes =
    DateTime.fromMicrosecondsSinceEpoch(seconts * 1000);

    return  DateFormat.yMMMd().format(Datetimes); // Apr 8, 2020

  }

List<RowofCells> loadDataFromDoce(QuerySnapshot document ){
 return  List<RowofCells>.from(
      document.docs.map((e)  {
        RowofCells row =    RowofCells.manual(e.data() as Map<String, dynamic>) ;
        row.addMap({"id":e.id});
        return row ;
      }).toList()) ;
}
}
