import 'package:flutter/material.dart';
import 'package:mybmirecord/ViewModel_Controller/recordpageController.dart';
import 'package:mybmirecord/Widget_Custom/customLineGraph/graphCard.dart';
import 'package:mybmirecord/static/forRelativeSize.dart';

Widget recordGraph(BuildContext context, RecordPageController controller) {
  double widthsize = RelativeSizeClass(context).widthSize!;
  double heightsize = RelativeSizeClass(context).heightSize!;
  double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;

  return Row(
    children: [
      /*
      0번 그래프 : BMI 수치 그래프
      1번 그래프 : 키 그래프
      2번 그래프 : 몸무게 그래프
      */
      // 0번 그래프
      Visibility(
        visible: controller.graphSelect.value == 0,
        child: Container(
          color: Colors.amber.withAlpha(50),
          width: widthsize,
          height: heightsize * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.records.length,
            itemBuilder: (context, index) {
              return graphCard().lineGraphCell(
                  controller.graphSelect.value,
                  widthsize * 0.2,
                  heightsize * 0.22, //height 1
                  controller.minBMI * 0.1, //min 그래프 y 축의 최소값
                  controller.maxBMI * 1.1, //max 그래프에서 보여줄 최대값.
                  index == 0
                      ? null
                      : controller.records[index - 1].bmi, // 시작값. 직전 측정값
                  controller.records[index].bmi, // 해당 날짜의 측정 실제 값.
                  index + 1 < controller.records.length
                      ? controller.records[index + 1].bmi
                      : null,
                  3,
                  heightsize * 0.03, //height 2  가로축의 값을 입력하는 파트
                  controller.records[index].timestamp,
                  heightsize * 0.01, //height 3 그래프와 가로축 사이의 여백
                  fsizeX: fsizeSmall);
            },
          ),
        ),
      ),
      //1번 그래프
      Visibility(
        visible: controller.graphSelect.value == 1,
        child: Container(
          color: Colors.blue[50],
          width: widthsize,
          height: heightsize * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.records.length,
            itemBuilder: (context, index) {
              return graphCard().lineGraphCell(
                  controller.graphSelect.value,
                  widthsize * 0.2,
                  heightsize * 0.22,
                  controller.minHeight * 0.3,
                  controller.maxHeight * 1.1, //max 그래프에서 보여줄 최대값.
                  index == 0
                      ? null
                      : controller.records[index - 1].height, // 시작값. 직전 측정값
                  controller.records[index].height, // 해당 날짜의 측정 실제 값.
                  index + 1 < controller.records.length
                      ? controller.records[index + 1].height
                      : null,
                  3,
                  heightsize * 0.03,
                  controller.records[index].timestamp,
                  heightsize * 0.01,
                  fsizeX: fsizeSmall);
            },
          ),
        ),
      ),
      //2번 그래프
      Visibility(
        visible: controller.graphSelect.value == 2,
        child: Container(
          color: Colors.green[50],
          width: widthsize,
          height: heightsize * 0.26,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.records.length,
            itemBuilder: (context, index) {
              return graphCard().lineGraphCell(
                  controller.graphSelect.value,
                  widthsize * 0.2,
                  heightsize * 0.22,
                  controller.minWeight * 0.15,
                  controller.maxWeight * 1.2, //max 그래프에서 보여줄 최대값.
                  index == 0
                      ? null
                      : controller.records[index - 1].weight, // 시작값. 직전 측정값
                  controller.records[index].weight, // 해당 날짜의 측정 실제 값.
                  index + 1 < controller.records.length
                      ? controller.records[index + 1].weight
                      : null,
                  3,
                  heightsize * 0.03,
                  controller.records[index].timestamp,
                  heightsize * 0.01,
                  fsizeX: fsizeSmall);
            },
          ),
        ),
      ),
    ],
  );
}
