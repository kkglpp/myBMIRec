import 'dart:io';

import '../Model_dataModel/bmi_record.dart';
import '../Model_datahandler/database_handler_impl.dart';

class SqliteRepository {
  deleteRecord(int recordKey) async {
    DatabaseHandlerImpl db = DatabaseHandlerImpl();
    bool rs = await db.deleteRecord(recordKey);
    return rs;
  }

  Future<List<BMIrecord>> bringRecord() async {
    DatabaseHandlerImpl db = DatabaseHandlerImpl();
    List<BMIrecord> records;
    records = await db.queryRecord();
    return records;
  }

  saveMyBMI(String? imgPath, double weight, double height, double bmi) async {
    // print("$bmi // 키:  $height // 몸무게: $weight");
    DatabaseHandlerImpl dh = DatabaseHandlerImpl();
    int nowYear = DateTime.now().year;
    int nowday = DateTime.now().day;
    int nowMonth = DateTime.now().month;
    int rs = 0;
    BMIrecord bmiModel;

    if (imgPath == "1") {
      bmiModel = BMIrecord(
        weight: weight,
        height: height,
        bmi: bmi,
        timestamp: "$nowYear / $nowMonth / $nowday",
        // imgbyte: await File(imgPath.value).readAsBytes(),
      );
    } else {
      bmiModel = BMIrecord(
        weight: weight,
        height: height,
        bmi: bmi,
        timestamp: "$nowYear / $nowMonth / $nowday",
        imgbyte: await File(imgPath!).readAsBytes(),
      );
    }
    // print(bmiModel.imgbyte);
    rs = await dh.insertRecord(
      bmiModel,
    );
    return rs;
  } //end of save

  Future<BMIrecord> bringQuery(int seq) async {
    final DatabaseHandlerImpl db = DatabaseHandlerImpl();
    BMIrecord? bmi;
    bmi = (await db.queryOneRecord(seq))[0];
    return bmi;
  } //end of birngQuery
}
