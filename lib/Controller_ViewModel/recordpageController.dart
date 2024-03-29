import 'package:get/get.dart';

class RecordPageController extends GetxController {
  RxBool loadRec = false.obs;

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
}
