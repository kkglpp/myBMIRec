import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/View/renewalRecordPage.dart';
import 'package:mybmirecord/View/renewalResultbmiPage.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpageController.dart';

import 'package:mybmirecord/Widget_Custom/circleChart.dart';
import 'package:mybmirecord/Widget_Custom/CustomWidget.dart';
import 'package:mybmirecord/static/forRelativeSize.dart';


class InsertPage extends StatelessWidget {
  const InsertPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InsertPageController());
    double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge= RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge= RelativeSizeClass(context).customFontSizeXL!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*
            - 키 (height) 입력 하는 파트 - 
            높이 : height 0.09
             */
            GetX<InsertPageController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthsize * 0.3,
                    height: heightsize * 0.09,
                    // color: Colors.blue,
                    child: Center(
                      child: customText(
                          "${controller.height.toStringAsFixed(1)}cm",
                          fsizeLarge,
                          'C'),
                    ),
                  ),
                  Container(
                    // color: Colors.amber,
                    width: widthsize * 0.55,
                    height: heightsize * 0.09,
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
                  Container(
                    // color: Colors.green,
                    width: widthsize * 0.15,
                    height: heightsize * 0.09,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.pink,
                          height: heightsize*0.045,
                          child: IconButton(
                            onPressed: (){
                              controller.plusHeight();
                            },
                            icon: Icon(Icons.keyboard_arrow_up_sharp,
                            size: fsizeXLarge*1.2,)
                            ),
                        ),
                        const Spacer(),
                        Container(
                          // color: Colors.yellow,
                          height: heightsize*0.045,
                          child: IconButton(
                            onPressed: (){
                              controller.subHeight();
                            },
                            icon: Icon(Icons.keyboard_arrow_down_sharp,
                            size: fsizeXLarge*1.2,)
                            ),
                        ),
                      ],
                    ),
                  ),                
                  SizedBox(
                    width: widthsize*0.05,
                  )  
                ],
              );
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
              child: const Divider(),
            ),
            /*
            - 몸무게 (weight) 입력 하는 파트 - 
            높이 : height 0.09
             */
            GetX<InsertPageController>(builder: (controller) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: widthsize * 0.3,
                    height: heightsize * 0.09,
                    // color: Colors.blue,
                    child: Center(
                      child: customText(
                          "${controller.weight.toStringAsFixed(1)} kg",
                          fsizeLarge,
                          'C'),
                    ),
                  ),

                  SizedBox(
                    // color: Colors.amber,
                    width: widthsize * 0.55,
                    height: heightsize * 0.09,
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
                  Container(
                    // color: Colors.green,
                    width: widthsize * 0.15,
                    height: heightsize * 0.09,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.pink,
                          height: heightsize*0.045,
                          child: IconButton(
                            onPressed: (){
                              controller.plusWeight();
                            },
                            icon: Icon(Icons.keyboard_arrow_up_sharp,
                            size: fsizeXLarge*1.2,)
                            ),
                        ),
                        const Spacer(),
                        Container(
                          // color: Colors.yellow,
                          height: heightsize*0.045,
                          child: IconButton(
                            onPressed: (){
                              controller.subWeight();
                              
                            },
                            icon: Icon(Icons.keyboard_arrow_down_sharp,
                            size: fsizeXLarge*1.2,)
                            ),
                        ),
                        

                      ],
                    ),
                  ),                        
                  SizedBox(
                    width: widthsize * 0.05,
                  ),                  
                ],
              );
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
              child: Divider(),
            ),            
//여기까지 0.15
            const Spacer(),
            /* 
            BMI 수치를 표시해주는 칸. 
            사진을 입력할지 고르는 Switch
            */
            Container(
              // color: Colors.amber,
              width: widthsize,
              height: heightsize * 0.05,
              child:                   GetX<InsertPageController>(builder: (controller) {
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
                          child: Row(
                            children: [
                              customText(
                                  "BMI : ${controller.bmi.toStringAsFixed(1)}",
                                  fsizeXLarge,
                                  "L"),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                            // color: Colors.amber,
                            width: widthsize * 0.3,
                            height: heightsize * 0.05,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customText(
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
                        // SizedBox(
                        //   width: widthsize*0.05,
                        // ),                            
                      ],
                    );
                  }),

            ),
const Spacer(),            
            /*
            BMI 수치를 시각화 하는 부분
            전체 높이 : heightsize * 0.6
             */
            Container(
              // color: Colors.amber,
              width: widthsize,
              height: heightsize * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /*
                  Switch에 따른 화면전환
                  true ->사진을 고르는 화면
                  false -> BMI 와 연동되는 원
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
                        : Container(
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
                  // const Spacer(),

                ],
              ),
            ),
            const Spacer(),
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
              height: heightsize * 0.01,
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
            const Spacer(),
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
