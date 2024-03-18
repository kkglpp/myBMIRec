import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybmirecord/Model/bmi_record.dart';
import 'package:mybmirecord/datahandler/database_handler.dart';
import 'package:mybmirecord/View/renewal_resultbmiPage.dart';

class InsertPageController extends GetxController {
  //field
  RxDouble height = 170.0.obs;
  RxDouble weight = 50.0.obs;
  RxDouble bmi = (50 / (1.7 * 1.7)).obs;
  RxBool viewType = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  RxString imgPath = "1".obs;

  // RxDouble bmi = (height.value /((weight.value/100)*(weight.value/100))).obs;

  //Function.
  changeHeight(double newHeight) {
    height.value = newHeight.obs.value;
    calcBMI(height, weight);
  }

  changeWeight(double newWeight) {
    weight.value = newWeight.obs.value;
    calcBMI(height, weight);
  }

  calcBMI(RxDouble h, RxDouble w) {
    bmi.value = (w / ((h / 100) * (h / 100))).obs.value;
  }

  selectImage() async {
    XFile? tempFile = await imgPicker.pickImage(source: ImageSource.gallery);
    if (tempFile != null) {
      imgPath.value = tempFile!.path;
      print("tempFile : $tempFile");
      print("tempFile path : ${tempFile.path}");
    } else {
      print("사진 가져오지 않음.");
    }
  }

  saveMyBMI() async {
    print("$bmi // 키:  $height // 몸무게: $weight");
    DatabaseHandler dh = DatabaseHandler();
    int nowYear = DateTime.now().year;
    int nowday = DateTime.now().day;
    int nowMonth = DateTime.now().month;
    int rs = 0;
    BMIrecord bmiModel;
    if (imgPath.value == "1") {
      bmiModel = BMIrecord(
        weight: weight.value,
        height: height.value,
        bmi: bmi.value,
        timestamp: "$nowYear / $nowMonth / $nowday",
        // imgbyte: await File(imgPath.value).readAsBytes(),
      );
    } else {
      bmiModel = BMIrecord(
        weight: weight.value,
        height: height.value,
        bmi: bmi.value,
        timestamp: "$nowYear / $nowMonth / $nowday",
        imgbyte: await File(imgPath.value).readAsBytes(),
      );
    }

    print(bmiModel.imgbyte);
    rs = await dh.insertRecord(
      bmiModel,
    );

    if (rs == 0) {
      print("저장실패");
    } else {
      print("??");
      return rs;
    }
  } //end of save
}
