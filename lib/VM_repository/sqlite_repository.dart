import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/datahandler/database_handler.dart';

class SqliteRepository{

  deleteRecord(int recordKey)  async{
    DatabaseHandler db = DatabaseHandler();
    bool rs =  await db.deleteRecord(recordKey);
    return rs;
  }

  Future<List<BMIrecord>> bringRecord() async{
    DatabaseHandler db = DatabaseHandler();
    List<BMIrecord> records ;

    records = await db.queryRecord();
    print("개수 : ${records.length}");

    return records;

  }

}