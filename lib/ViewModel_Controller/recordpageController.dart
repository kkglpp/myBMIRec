import 'dart:math';

import 'package:get/get.dart';
import 'package:mybmirecord/Model_Func/sqlite_repository.dart';
import 'package:mybmirecord/Model_dataModel/bmi_record.dart';

class RecordPageController extends GetxController {

  // 그래프내에 표시할 최대 최소값등의 선언.
  double minBMI = 5 ;
  double maxBMI = 60;
  double minHeight=0;
  double maxHeight=180;
  double minWeight=30;
  double maxWeight=100;

  RxBool loadRec = false.obs;
  List<BMIrecord> records = [];
  RxInt graphSelect = 0.obs;

  selectBMIGraph() {
    graphSelect.value = 0;
  }

  selectHeightGraph() {
    graphSelect.value = 1;
  }

  selectWeightGraph() {
    graphSelect.value = 2;
  }

  bringRecords()async {
    SqliteRepository sql = SqliteRepository();

    // records.addAll(await sql.bringRecord()) ;
    records = await sql.bringRecord();
    if (records.isNotEmpty){
    minBMI = (records.map((record) => record.bmi).toList()).reduce(min);
    maxBMI = (records.map((record) => record.bmi).toList()).reduce(max);
    minWeight = (records.map((record) => record.weight).toList()).reduce(min);
    maxWeight = (records.map((record) => record.weight).toList()).reduce(max);
    minHeight = (records.map((record) => record.height).toList()).reduce(min);
    maxHeight = (records.map((record) => record.height).toList()).reduce(max);
    }
    loadRec.value = true;
  }
}
