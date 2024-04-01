import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybmirecord/View/View_Component/insert_circlechart.dart';
import 'package:mybmirecord/View/View_Component/insert_height.dart';
import 'package:mybmirecord/View/View_Component/insert_image.dart';
import 'package:mybmirecord/View/View_Component/insert_weight.dart';
import 'package:mybmirecord/View/RecordPage.dart';
import 'package:mybmirecord/View/ResultbmiPage.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpageController.dart';

import 'package:mybmirecord/Widget_Custom/CustomWidget.dart';
import 'package:mybmirecord/static/forRelativeSize.dart';

class InsertPage extends StatelessWidget {
  const InsertPage({super.key});

  // late double widthsize;
  // late double heightsize;
  // late double fsizeSmall;
  // late double fsizeMiddle;
  // late double fsizeLarge;
  // late double fsizeXLarge;

  // setSizeValue(BuildContext context) {
  //   widthsize = RelativeSizeClass(context).widthSize!;
  //   heightsize = RelativeSizeClass(context).heightSize!;
  //   fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  //   fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  //   fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  //   fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(InsertPageController());
    // setSizeValue(context);

    double widthsize = RelativeSizeClass(context).widthSize!;
    double heightsize = RelativeSizeClass(context).heightSize!;
    double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
    double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
    double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
    double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*
            - 키 (height)와 몸무게 (weight)를 입력 하는 파트 - 
            높이 : 각 0.09
            + Divider 2개.
             */
            GetX<InsertPageController>(builder: (controller) {
              return insertHeight(context, controller);
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
              child: const Divider(),
            ),
            GetX<InsertPageController>(builder: (controller) {
              return insertWeight(context, controller);
            }),
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
              child: const Divider(),
            ),
            //수치를 입력하는 파트와 그 아래 파트를 구분짓는 여백을 Spacer로 지정.
            const Spacer(),
            /* 
            BMI 수치를 표시해주는 칸과 사진을 입력할지 고르는 Switch가 들어간 파트.
            Container로 한 박스로 묶음.
            높이 : 0.05  (0.023 +@ )
            */
            Container(
              // color: Colors.amber,
              width: widthsize,
              height: heightsize * 0.05,
              child: GetX<InsertPageController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: widthsize * 0.05,
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
                              "사진 고르기 ➤ ",
                              fsizeLarge,
                              "R",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: Colors.red,
                        width: widthsize * 0.2,
                        child: Switch(
                          value: controller.viewType.value,
                          onChanged: (value) {
                            controller.viewType.value = value;
                          },
                        ),
                      ),
                      // SizedBox(
                      //   width: widthsize*0.05,
                      // ),
                    ],
                  );
                },
              ),
            ),
            // 계산된 BMI 수치와, 화면 전환용 Switch를 위한 Container 종료.
            // 그 하단과의 여백을 Spacer로 지정.
            const Spacer(),
            /*
            BMI 수치를 시각화 하는 부분 + 화면 전환시 사진을 입력 받는 부분.
            전체 높이 : heightsize * 0.5   여기까지 0.73 +@
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
                  GetX<InsertPageController>(
                    builder: (ctrl) {
                      return ctrl.viewType.value
                          // 스위치를 on으로 바꾸면, 사진을 넣을 수 있는 화면 표시.
                          //스위치 on 일때 이미지를 입력받는 화면 Widget.
                          //스위치 off 일때 BMI 수치의 원의 크기로 시각화 시킨 widget
                          ? insertImg(context, ctrl) // image 입력받는 Widget
                          : insertCircleChart(context); // 시각화 시킨 Widget
                    },
                  ),
                ],
              ),
            ),
            //BMI 를 시각화한 파트 및 이미지를 입력받는 파트 하단의 여백을  Spacer 로 지정
            const Spacer(),
            /*
            저장하기 버튼과 목록 보기 버튼
            높이 : 각 0.075 중간에 여백 0.01
            총 높이 0.89 + 2Diveder + 다수의 Spacers
            */
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save,
                      size: fsizeXLarge * 1.6,
                    ),
                    Text(
                      "  저 장 하 기",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: fsizeLarge),
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
                Get.off(() => RecordPage());
              },
              child: SizedBox(
                width: widthsize * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu_sharp, size: fsizeXLarge * 1.6),
                    Text(
                      "   목 록 보 기",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: fsizeLarge),
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

  // Save My BMI  저장하기

  _saveMyRec() async {
    int rs = await Get.find<InsertPageController>().saveMyBMI();
    Get.delete<InsertPageController>();
    Get.off(() => ResultBMIPage(recordKey: rs));
  }
} //end of class
