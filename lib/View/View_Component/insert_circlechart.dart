import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:mybmirecord/ViewModel_Controller/insertpage_controller.dart';
import 'package:mybmirecord/Widget_Custom/circle_chart.dart';
import 'package:mybmirecord/static/relative_size.dart';

//BMI 수치에 따라 원의크기가 달라지도록하여, 시각적으로 BMI 위험도 상태를 표시.
//배경에 체중미달 정상 체중 과체중 비만 체중등의 경계선을 제시하여 기준점 제시.
Widget insertCircleChart(BuildContext context) {
  double widthsize = RelativeSizeClass(context).widthSize!;
  double heightsize = RelativeSizeClass(context).heightSize!;
  // double fsizeSmall = RelativeSizeClass(context).customFontSizeS!;
  // double fsizeMiddle = RelativeSizeClass(context).customFontSizeM!;
  // double fsizeLarge = RelativeSizeClass(context).customFontSizeL!;
  // double fsizeXLarge = RelativeSizeClass(context).customFontSizeXL!;

  return SizedBox(
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
                border: Border.all(color: Colors.red, width: 3)),
            width: heightsize * 0.5,
            height: heightsize * 0.5,
          ),
          //정상체중의 범위를 표시해주시는 원. BMI 수치 30 까지가 해당함.
          Positioned(
            child: CustomPaint(
              size: Size(heightsize * 0.5, heightsize * 0.5),
              painter: CircleChart(Colors.blue.withAlpha(50), Colors.blue,
                  radius: (heightsize * 0.25 * (30) / 45)),
            ),
          ),
          // 저체중의 범위를 표시해주시는 원. BMI 수치 18.5 까지가 해당함.

          Positioned(
            child: CustomPaint(
              size: Size(heightsize * 0.5, heightsize * 0.5),
              painter: CircleChart(Colors.purple.withAlpha(50), Colors.purple,
                  radius: (heightsize * 0.25 * (18.5) / 45)),
            ),
          ),

          /* 
                              실제 BMI를 원으로 표현하는 부분
                              그래프로 표시되는 최대값은 50으로 고정.
                              */
          GetX<InsertPageController>(builder: (controller) {
            return Positioned(
              child: CustomPaint(
                size: Size(heightsize * 0.5, heightsize * 0.5),
                painter: CircleChart(
                    Colors.green.withAlpha((255 *
                            (controller.bmi.value > 45
                                ? 45
                                : controller.bmi.value) /
                            45)
                        .round()),
                    const Color.fromARGB(255, 31, 87, 33),
                    radius: (heightsize *
                        0.25 *
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
}
