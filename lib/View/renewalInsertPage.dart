import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/Controller/insertpageController.dart';
import 'package:mybmirecord/View/renewal_recordpage.dart';
import 'package:mybmirecord/View/renewal_resultbmipage.dart';
import 'package:mybmirecord/Custom/circleChart.dart';
import 'package:mybmirecord/Custom/textcustom.dart';
import 'package:mybmirecord/static/forRelativeSize.dart';


class InsertPage extends StatelessWidget {
  const InsertPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InsertPageController());
 
    // double widthsize = 350;
    double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge= RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge= RelativeSizeClass(context).customFontSizeXL!;
    // double heightsize = 700;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*
            - 키 (height) 입력 하는 파트 - 
            높이 : height 0.075
            
             */
            GetX<InsertPageController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthsize * 0.35,
                    height: heightsize * 0.075,
                    // color: Colors.blue,
                    child: Center(
                      child: TextCustom().customText(
                          "${controller.height.toStringAsFixed(1)}cm",
                          fsizeLarge,
                          'C'),
                    ),
                  ),
                  SizedBox(
                    width: widthsize * 0.05,
                  ),
                  SizedBox(
                    // color: Colors.amber,
                    width: widthsize * 0.6,
                    height: heightsize * 0.075,
                    child: Slider(
                      value: controller.height.value,
                      min: 100,
                      max: 250,
                      divisions: 1500,
                      onChanged: (value) {
                        controller.changeHeight(value);
                      },
                    ),
                  ),
                ],
              );
            }),
            /*
            - 몸무게 (weight) 입력 하는 파트 - 
            높이 : height 0.075
             */
            GetX<InsertPageController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthsize * 0.35,
                    height: heightsize * 0.075,
                    // color: Colors.blue,
                    child: Center(
                      child: TextCustom().customText(
                          "${controller.weight.toStringAsFixed(1)} kg",
                          fsizeLarge,
                          'C'),
                    ),
                  ),
                  SizedBox(
                    width: widthsize * 0.05,
                  ),
                  SizedBox(
                    // color: Colors.amber,
                    width: widthsize * 0.6,
                    height: heightsize * 0.075,
                    child: Slider(
                      value: controller.weight.value,
                      min: 30,
                      max: 180,
                      divisions: 1500,
                      onChanged: (value) {

                        controller.changeWeight(value);
                      },
                    ),
                  ),
                ],
              );
            }),
//여기까지 0.15
            // 여백을 위한 sizedbox
            SizedBox(
              // color: Colors.amber,
              height: heightsize * 0.05,
            ),
            /*
            BMI 수치를 시각화 하는 부분
            전체 높이 : heightsize * 0.7
             */

            Container(
              // color: Colors.amber,
              width: widthsize,
              height: heightsize * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GetX<InsertPageController>(builder: (controller) {
                    return Row( 
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: widthsize*0.05,
                        ),
                        SizedBox(

                          width: widthsize * 0.4,
                          height: heightsize * 0.05,
                          // color: Colors.grey,
                          child: TextCustom().customText(
                              "BMI : ${controller.bmi.toStringAsFixed(1)}",
                              fsizeXLarge,
                              "L"),
                        ),
                        const Spacer(),
                        SizedBox(
                            // color: Colors.amber,
                            width: widthsize * 0.3,
                            height: heightsize * 0.05,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextCustom().customText(
                                    "사진 고르기 ➤ ", fsizeLarge, "R",),
                              ],
                            )),
                        SizedBox(
                          // color: Colors.red,
                          width: widthsize*0.2,
                          child: Switch(
                              value: controller.viewType.value,
                              onChanged: (value) {
                                controller.viewType.value = value;
                              }),
                        ),
                        SizedBox(
                          width: widthsize*0.05,
                        ),                            
                      ],
                    );
                  }),
            const Spacer(),

                  /*
                  Switch에 따른 화면전환
                  눈바디 사진 입력 필요
                   */
                  GetX<InsertPageController>(builder: (ctrl) {
                    return ctrl.viewType.value
                        ? SizedBox(
                            width: widthsize,
                            height: heightsize * 0.5,
                            // color: Colors.blue,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: heightsize * 0.025,
                                ),
                                SizedBox(
                                    child: ctrl.imgPath.value == "1"
                                        ? Image.asset(
                                            "images/0.jpeg",
                                            height: heightsize * 0.35,
                                            width: widthsize,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Image.file(
                                            File(ctrl.imgPath.value),
                                            height: heightsize * 0.35,
                                            width: widthsize,
                                            fit: BoxFit.fitHeight,
                                          )),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple[200],
                                      foregroundColor: Colors.white,
                                      minimumSize: Size(
                                          widthsize * 0.9, heightsize * 0.05)),
                                  onPressed: () {
                                    _selectImage(ctrl);
                                  },
                                  child: Text(
                                    "눈바디 사진 선택",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: fsizeMiddle),
                                  ),
                                )
                              ],
                            ),
                          )
                        /*
                  BMI에 따라 달라지는 원의 크기
                  Zstack으로 쌓아서 겹쳐지게 표현.
                   */

                        : SizedBox(
                            width: widthsize,
                            height: heightsize * 0.5,
                            // color: Colors.amber,
                            child: Center(
                              child: Stack(
                                children: [
                                  // BMI 최대치 (720)에 해당하는 원
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.withAlpha(40),
                                        border: Border.all(
                                            color: Colors.red, width: 3)),
                                    width: heightsize * 0.5,
                                    height: heightsize * 0.5,
                                  ),
                                  Positioned(
                                    child: CustomPaint(
                                      size: Size(
                                          heightsize * 0.5, heightsize * 0.5),
                                      painter: CircleChart(
                                          Colors.blue.withAlpha(50),
                                          Colors.blue,
                                          radius:
                                              (heightsize * 0.25 * (30) / 45)),
                                    ),
                                  ),
                                  Positioned(
                                    child: CustomPaint(
                                      size: Size(
                                          heightsize * 0.5, heightsize * 0.5),
                                      painter: CircleChart(
                                          Colors.purple.withAlpha(50),
                                          Colors.purple,
                                          radius:
                                              (heightsize * 0.25 * (18.5) / 45)),
                                    ),
                                  ),

                                  /* 
                              실제 BMI를 원으로 표현하는 부분
                              그래프로 표시되는 최대값은 50으로 고정.
                              */
                                  GetX<InsertPageController>(
                                      builder: (controller) {
                                    return Positioned(
                                      child: CustomPaint(
                                        size: Size(
                                            heightsize * 0.5,heightsize * 0.5),
                                        painter: CircleChart(
                                            Colors.green.withAlpha((255 *
                                                    (controller.bmi.value > 45
                                                        ? 45
                                                        : controller
                                                            .bmi.value) /
                                                    45)
                                                .round()),
                                            const Color.fromARGB(
                                                255, 31, 87, 33),
                                            radius: (heightsize * 0.25 *
                                                (controller.bmi.value > 45
                                                    ? 45
                                                    : controller.bmi.value) /
                                                45)),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                  }),
                  const Spacer(),

                ],
              ),
            ),
            SizedBox(
              height: heightsize*0.02,
            ),
//여기까지 0.85

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(widthsize * 0.8, heightsize * 0.075)),
              onPressed: () {
                _saveMyRec();
              },
              child: SizedBox(
                width: widthsize * 0.8,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, size: fsizeXLarge*1.6,),
                    Text(
                      "  저 장 하 기",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: fsizeLarge),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: heightsize * 0.005,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(widthsize * 0.8, heightsize * 0.075)),
              onPressed: () {
                Get.off(()=>ReRecordPage());
              },
              child: SizedBox(
                width: widthsize * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_sharp, size : fsizeXLarge*1.6),
                    Text(
                      "   목 록 보 기",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: fsizeLarge),
                    ),
                  ],
                ),
              ),
            ),
// 여기까지 0.95
            SizedBox(
              // color: Colors.black,
              height: heightsize * 0.01,
            )
          ],
        ),
      ),
    );
  } //end of widget

  // 갤러리 들어가는 함수
  _selectImage(InsertPageController controller) {
    controller.selectImage();
  }

  // Save My BMI  저장하기

  _saveMyRec() async {
    int rs = await Get.find<InsertPageController>().saveMyBMI();
    Get.delete<InsertPageController>();
    Get.off(() => ResultBMIPage(recordKey: rs));
  }
} //end of class
