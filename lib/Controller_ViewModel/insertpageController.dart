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

  //Function.
  changeHeight(double newHeight) {
    height.value = newHeight;
    bmi.value= CalcBMI().calcbmi(height.value,weight.value);
  } //end of changeofHeight

  changeWeight(double newWeight) {
    weight.value = newWeight;
    bmi.value= CalcBMI().calcbmi(height.value,weight.value);
    // calcBMI(height, weight);
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
