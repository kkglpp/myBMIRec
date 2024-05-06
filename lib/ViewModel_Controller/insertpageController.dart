import 'dart:async';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybmirecord/Model_Func/calcBMI.dart';
import 'package:mybmirecord/Model_Func/sqlite_repository.dart';

class InsertPageController extends GetxController {
  //field
  RxDouble height = 170.0.obs;
  RxDouble weight = 50.0.obs;
  RxDouble bmi = (50 / (1.7 * 1.7)).obs;
  RxBool viewType = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  RxString imgPath = "1".obs;
  Timer? _timer;

  //Function.
  changeHeight(double newHeight) {
    height.value = newHeight;
    bmi.value = CalcBMI().calcbmi(height.value, weight.value);
  } //end of changeofHeight

  plusHeight() {
    if (height.value < 250) {
      height.value += 0.1;
      bmi.value = CalcBMI().calcbmi(height.value, weight.value);
    }
  } //end of changeofHeight

  subHeight() {
    if(height.value>100){
    height.value -= 0.1;
    bmi.value = CalcBMI().calcbmi(height.value, weight.value);
    }
  } //end of changeofHeight

  changeWeight(double newWeight) {
    weight.value = newWeight;
    bmi.value = CalcBMI().calcbmi(height.value, weight.value);
    // calcBMI(height, weight);
  } //end of changeWeight

  plusWeight() {
    if (weight.value < 180) {
      weight.value += 0.1;
      bmi.value = CalcBMI().calcbmi(height.value, weight.value);
    }
    // calcBMI(height, weight);
  } //end of changeWeight

  subWeight() {
    if(weight.value > 30 ){
    weight.value -= 0.1;
    bmi.value = CalcBMI().calcbmi(height.value, weight.value);
    // calcBMI(height, weight);
    }
  } //end of changeWeight

  selectImage() async {
    XFile? tempFile;
    try {
      tempFile = await imgPicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      tempFile = null;
    }
    if (tempFile != null) {
      imgPath.value = tempFile.path;
    } else {}
  } // end of selectImage

  repeatedPlusHeight() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        plusHeight();
      },
    );
  }

  repeatedSubHeight() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        subHeight();
      },
    );
  }
  repeatedPlusWeight() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        plusWeight();
      },
    );
  }

  repeatedSubWeight() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        subWeight();
      },
    );
  }

  timerEnd(){
    _timer?.cancel();
  }

  saveMyBMI() async {
    int rs = 0;
    rs = await SqliteRepository()
        .saveMyBMI(imgPath.value, weight.value, height.value, bmi.value);
    if (rs == 0) {
    } else {
      return rs;
    }
  } //end of saveMyBMI
}//end of class
