import 'package:mybmirecord/Model_dataModel/bmi_record.dart';
import 'package:mybmirecord/Model_datahandler/database_handler.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandlerImpl implements DatabaseHandler {
  // 사용할 sql 구문 모음
  final String createStr =
      'CREATE TABLE bmirecord2(seq integer primary key autoincrement, insertdate String, weight real, height real, bmi real, image blob)';
  final String insertStr =
      'INSERT INTO bmirecord2(insertdate,weight, height, bmi, image ) VALUES (?,?,?,?,?)';
  final String deleteStr = "DELETE FROM bmirecord2 WHERE seq = ? ";
  final String updateStr =
      'UPDATE bmirecord2 SET insertdate = ? ,weight = ?, height = ?, bmi = ? , image = ? WHERE seq = ?';
  final String queryAllStr = 'SELECT * FROM bmirecord2';
  final String queryOneStr = 'SELECT * FROM bmirecord2 WHERE seq = ?';

  //Db 불러오기.
  @override
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'bmirecord2.db'), //db로 써도되고 sqlite로 써도 된다.
      onCreate: (database, version) async {
        //app 실행했을때 db가 없으면 생성되는거
        await database.execute(createStr);
      },
      version: 1,
    );
  }

  // QueryAddress
  @override
  Future<List<BMIrecord>> queryRecord() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from bmirecord2');
    // print("QueryRecord 가져옴 dataHandler");
    return queryResult.map((e) => BMIrecord.fromMap(e)).toList();
  }

  @override
  Future<int> insertRecord(BMIrecord bmi) async {
    int pk = 0;
    final Database db = await initializeDB();

    try {
      pk = await db.rawInsert(insertStr, [
        bmi.timestamp,
        bmi.weight,
        bmi.height,
        bmi.bmi,
        bmi.imgbyte,
      ]);
    } catch (e) {
      // print("db handler Try 에러$e");
    }

    return pk;
  }

  @override
  Future<List<BMIrecord>> queryOneRecord(int pk) async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery(queryOneStr, [pk]);
    // print("쿼리 결과 : $queryResult");
    return queryResult.map((e) => BMIrecord.fromMap(e)).toList();
  }

  // DeleteAddress
  @override
  deleteRecord(int recordKey) async {
    final Database db = await initializeDB();
    try {
      await db.rawDelete(deleteStr, [recordKey]);
    } catch (e) {
      // print(e);
      return false;
    }
    return true;
  }

  @override
  updateRecord(BMIrecord bmi) async {
    final Database db = await initializeDB();
    await db.rawUpdate(updateStr,
        [bmi.timestamp, bmi.weight, bmi.height, bmi.bmi, null, bmi.seq]);
  }
}
