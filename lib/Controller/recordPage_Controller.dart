import 'package:get/get.dart';

class RecordPageController extends GetxController{

  

  RxBool loadRec = false.obs;

  RxInt graphSelect = 0.obs;

  selectBMIGraph(){
    graphSelect.value = 0;
    // print("graphType : ${graphSelect.value}");
  }
  selectHeightGraph(){
    graphSelect.value = 1;
    // print("graphType : ${graphSelect.value}");
  }
  selectWeightGraph(){
    graphSelect.value=2;
    // print("graphType : ${graphSelect.value}");
  }



}