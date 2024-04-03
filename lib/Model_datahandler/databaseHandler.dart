import 'package:mybmirecord/Model_dataModel/bmi_record.dart';

abstract class DatabaseHandler {
  initializeDB() {}
  queryRecord(){}
  insertRecord(BMIrecord bmi){}
  queryOneRecord(int pk){}
  deleteRecord(int recordKey) {}
  updateRecord(BMIrecord bmi) {}


}