import 'package:get/get.dart';
import 'package:mybmirecord/Model_dataModel/bmi_record.dart';
import 'package:mybmirecord/Model_Func/sqlite_repository.dart';

class ResultBMIPageController extends GetxController {
  RxBool querySuccess = false.obs;
  RxString? imgBytes;
  BMIrecord? bmirec;

  bringQuery(int seq) async {
    bmirec = await SqliteRepository().bringQuery(seq);
    querySuccess.value = true;
  }
}
