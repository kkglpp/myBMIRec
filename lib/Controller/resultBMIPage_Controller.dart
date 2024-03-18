import 'package:get/get.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/datahandler/database_handler.dart';

class ResultBMIPageController extends GetxController {
  RxBool querySuccess =false.obs;
  RxString? imgBytes ;
  BMIrecord? bmirec;
  


  bringQuery(int seq) async {
    final DatabaseHandler db = DatabaseHandler();

    bmirec = (await db.queryOneRecord(seq))[0];

    print("bmiRec_height : ${bmirec!.height}");
    print("bmiRec_weight : ${bmirec!.weight}");


    querySuccess.value = true;

  }

}